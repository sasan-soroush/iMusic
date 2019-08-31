//
//  DownloadViewController.swift
//  iMusic
//
//  Created by New User on 1/9/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import SDWebImage

extension DownloadViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addKeyboardNotifiactions()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setShowingSuggestion(hide: !searchResults.isEmpty)
    }
    
}

extension DownloadViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == searchSuggestionsTableView {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchSuggestionsTableView {
            
            if section == 0 {
                return recentSearches.count + 1
            } else {
                return popularSearches.count + 1
            }
            
        } else {
            return self.searchResults.count
        }
    }
    
    fileprivate func handleSuggestCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let padding : CGFloat = 10
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchSuggestionCell.id, for: indexPath) as! SearchSuggestionCell
        cell.selectionStyle = .none
        cell.suggestion.frame = CGRect(x: padding, y: padding/2, width: cell.frame.width - padding*2, height: cell.frame.height - padding)
        recentSearches = recentSearches.sorted{$0.count < $1.count}
        
        switch indexPath.section {
        case 0 :
            switch indexPath.row {
            case 0 : cell.title = "❖  Recent Searches"
            default : cell.suggest = recentSearches[indexPath.row - 1]
            }
            
        case 1 :
            switch indexPath.row {
            case 0 : cell.title = "❖  Popular Searches"
            default : cell.suggest = popularSearches[indexPath.row - 1]
            }
            
        default : break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchSuggestionsTableView {
            return handleSuggestCell(tableView, indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.id, for: indexPath) as! SearchResultTableViewCell
            setupCell(cell, indexPath)
            cell.searchResult = self.searchResults[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == searchSuggestionsTableView {
            return  view.frame.height/15
        } else {
            return view.frame.height/8
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchSuggestionsTableView {
            handleSuggestions(indexPath)
        } else {
            handleDownload(tableView, indexPath)
        }
    }
    
    fileprivate func handleSuggestions(_ indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        switch indexPath.section {
        case 0 :
            self.setShowingSuggestion(hide: true)
            searchBar.text = recentSearches[indexPath.row - 1]
            self.searchBar(self.searchBar, textDidChange: recentSearches[indexPath.row - 1])
        case 1 :
            self.setShowingSuggestion(hide: true)
            searchBar.text = popularSearches[indexPath.row - 1]
            self.searchBar(self.searchBar, textDidChange: recentSearches[indexPath.row - 1])
        default : break
        }
    }
    
    fileprivate func setupCell(_ cell: SearchResultTableViewCell, _ indexPath: IndexPath) {
        
        let paddingForTexts : CGFloat = 10
        
        cell.line.frame = CGRect(x: 0, y: cell.frame.height - 0.5, width: cell.frame.width, height: 0.5)
        cell.musicImage.frame = CGRect(x: 0, y: 5, width: cell.frame.height-10, height: cell.frame.height-10)
        cell.musicName.frame = CGRect(x: cell.musicImage.frame.maxX + 10, y: paddingForTexts, width: cell.frame.width - cell.musicImage.frame.width - 10 - 50, height: cell.frame.height/2-paddingForTexts)
        cell.musicArtist.frame = CGRect(x: cell.musicImage.frame.maxX + 10, y: cell.frame.height/2, width: cell.musicName.frame.width , height: cell.frame.height/2-paddingForTexts)
        cell.loadingBar.frame = CGRect(x: 0, y: 0, width: 0, height: cell.frame.height)
        cell.waitingBar.frame = CGRect(x: 0, y: cell.frame.height-2, width: cell.frame.width, height: 2)
        cell.checkMark.frame = CGRect(x: cell.frame.width - 35, y: cell.frame.height/2-8, width: 16, height: 16)
        cell.selectionStyle = .none
        
    }
    
}

extension DownloadViewController {
    
    //MARK:- download
    
    fileprivate func startDownloading(_ cell: SearchResultTableViewCell, _ searchResult: SearchResult , _ index : IndexPath) {
        self.isDownloading = true
        cell.waitingBar.startAnimating()
        cell.isDownloading = true
        API.download(downloadItem: searchResult, progHandler : { (progress) in
            
            cell.waitingBar.stopAnimating()
            cell.loadingBar.isHidden = false
            cell.loadingBar.frame = CGRect(x: 0, y: 0, width: cell.frame.width/100 * (progress), height: cell.frame.height)
            
        }) { (success, filePath) in
            
            if success {
                
                cell.waitingBar.stopAnimating()
                cell.loadingBar.isHidden = true
                self.searchResults[index.row].isDownloaded = true
                self.searchResultTableView.reloadRows(at: [index], with: UITableViewRowAnimation.left)
                
                
            } else {
                
                //TODO:- change it
                Helper.shared.alert(self, title: "", body: "دانلود موفقیت آمیز نبود.")
            }
            
            self.isDownloading = false
            cell.isDownloading = false
            
        }
    }
    
    fileprivate func handleDownload(_ tableView: UITableView, _ indexPath: IndexPath) {

        
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell else {return}
        let searchResult = self.searchResults[indexPath.row]
        
        if searchResult.isDownloaded == true {
            let track = self.searchResults[indexPath.row]
            let id  = track.id
            let filePath = helper.getSaveFileUrl(musicId: id)
            helper.pandoraPlay(fromTabBar: true, target: self, filePath: filePath)
            return
        }
        
        if !isDownloading {
            
            startDownloading(cell, searchResult ,indexPath)
            
        } else {
            
            if cell.isDownloading{

                API.request?.cancel()
                API.request = nil
                cell.waitingBar.stopAnimating()
                cell.loadingBar.isHidden = true
                
            } else {
                
                helper.alert(self, title: "✘", body: "لطفا صبر کنید تا دانلود در حال انجام تمام شود.")
                
            }
            
        }
    }
}

extension DownloadViewController {
    
    private func addKeyboardNotifiactions() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.searchBar.frame.origin.y = view.frame.height - 50 - keyboardSize.height
            searchResultTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
            searchSuggestionsTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.searchBar.frame.origin.y = view.frame.height - helper.getTabBarHeight() - 50
        searchResultTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
        searchSuggestionsTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
    }
    
}

extension DownloadViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        searchFor(query)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        self.searchResults.removeAll()
        self.searchResultTableView.reloadData()
        self.setShowingSuggestion(hide: false)
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    fileprivate func searchFor(_ text: String) {
        startIndicator()
        API.search(text: text) { (success, searchResultArray) in
            self.searchResults = searchResultArray
            self.searchResultTableView.reloadData()
            self.setShowingSuggestion(hide: true)
            self.stopIndicator()
        }
    }
    
    func setShowingSuggestion(hide : Bool) {
        if hide && isDownloading {
            return
        }
        self.searchSuggestionsTableView.isHidden = hide
        self.searchResultTableView.isHidden      = !hide
        self.isShowingSuggestions                = !hide
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else {
            Helper.shared.alert(self, title: "", body: "مشکلی با متن وارد شده وجود دارد.")
            stopIndicator()
            return
        }
        
        searchFor(text)
    }
    
}

class DownloadViewController : BaseViewControllerNormal {
    
    private var searchResults : [SearchResult] = []
    private var isDownloading : Bool           = false
    private var isShowingSuggestions : Bool    = false
    
    private var recentSearches = ["Linkin park numb" , "Katy perry lion" , "Imagine dragons dream" , "Rony james dio" , "Metallica fade to black" , "pavarati" , "Sirvan khosravi naro"]
    
    private var popularSearches = ["Mahasti" , "Arash Bia ba man" , "U2 New symphony" , "James Blunt hero" , "Rolling stones devided" , "Taylor Swift 22" , "Anathema flying"]
    
    private func setupView() {
        
        
        view.addSubview(searchBar)
        view.addSubview(searchResultTableView)
        view.addSubview(searchSuggestionsTableView)
        
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 10, y: view.frame.height - helper.getTabBarHeight() - 50 , width: view.frame.width - 20, height: 40)
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 8, vertical: 0)
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.id)
        searchResultTableView.separatorStyle = .none
        searchResultTableView.frame = CGRect(x: 10, y: logo.frame.maxY , width: view.frame.width-20, height: searchBar.frame.minY - logo.frame.maxY - 10)
        
        searchSuggestionsTableView.delegate = self
        searchSuggestionsTableView.dataSource = self
        searchSuggestionsTableView.register(SearchSuggestionCell.self, forCellReuseIdentifier: SearchSuggestionCell.id)
        searchSuggestionsTableView.separatorStyle = .none
        searchSuggestionsTableView.frame = searchResultTableView.frame
        
        setupSearchBar()
        
        view.addSubview(indicator)
        
    }
    
    private func setupSearchBar() {
        
        let cancelButtonAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        if let txtSearchField = searchBar.value(forKey: "_searchField") as? UITextField {
            txtSearchField.borderStyle = .none
            txtSearchField.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.25)
            txtSearchField.layer.cornerRadius = 8
            txtSearchField.clipsToBounds = true
            txtSearchField.keyboardAppearance = .dark
            txtSearchField.layer.borderColor = UIColor.MyTheme.gradientForBGColor.cgColor
            txtSearchField.layer.borderWidth = 0.5
            let attributedString = NSAttributedString(string: "موزیک مورد نظر را جستجو کنید", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray , NSAttributedStringKey.font : Font.IranYekanLight(size: 18) ])
            txtSearchField.attributedPlaceholder = attributedString
            
        }
        
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = UIColor.MyTheme.textFieldTextColor
        }
    }
    
    //MARK:- UI Properties
    
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.clipsToBounds = true
        bar.backgroundImage = UIImage()
        return bar
    }()
    
    let searchResultTableView : UITableView = {
        let view = UITableView(frame: .zero, style: UITableViewStyle.plain)
        view.backgroundColor = .clear
        return view
    }()
    
    let searchSuggestionsTableView : UITableView = {
        let view = UITableView(frame: .zero, style: UITableViewStyle.plain)
        view.backgroundColor = .clear
        return view
    }()
    
}















