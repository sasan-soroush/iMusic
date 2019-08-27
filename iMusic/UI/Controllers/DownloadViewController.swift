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
        searchResultTableView.isHidden = searchResults.isEmpty
        searchSuggestionsTableView.isHidden = !searchResultTableView.isHidden
    }
    
}

extension DownloadViewController : UITableViewDelegate , UITableViewDataSource {
    
    static var searchSugg = ["Linkin park numb" , "Katy perry lion" , "Imagine dragons dream" , "Rony james dio" , "Metallica fade to black" , "pavarati" , "Sirvan khosravi naro"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchSuggestionsTableView {
            return 7
        } else {
            return self.searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchSuggestionsTableView {
            let padding : CGFloat = 10
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchSuggestionCell.id, for: indexPath) as! SearchSuggestionCell
            cell.selectionStyle = .none
            cell.suggestion.frame = CGRect(x: padding, y: padding/2, width: cell.frame.width - padding*2, height: cell.frame.height - padding)
            DownloadViewController.searchSugg = DownloadViewController.searchSugg.sorted{$0.count < $1.count}
            cell.suggestion.text = DownloadViewController.searchSugg[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.id, for: indexPath) as! SearchResultTableViewCell
            setupCell(cell, indexPath)
            cell.searchResult = self.searchResults[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == searchSuggestionsTableView {
            return searchSuggestionsTableView.frame.height/10
        } else {
            return view.frame.height/8
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchSuggestionsTableView {
            self.searchBar.becomeFirstResponder()
            self.searchBar.text = DownloadViewController.searchSugg[indexPath.row]
        } else {
            handleDownload(tableView, indexPath)
        }
    }
    
    fileprivate func setupCell(_ cell: SearchResultTableViewCell, _ indexPath: IndexPath) {
        
        let paddingForTexts : CGFloat = 10
        
        cell.line.frame = CGRect(x: 0, y: cell.frame.height - 0.5, width: cell.frame.width, height: 0.5)
        cell.musicImage.frame = CGRect(x: 0, y: 5, width: cell.frame.height-10, height: cell.frame.height-10)
        cell.musicName.frame = CGRect(x: cell.musicImage.frame.maxX + 10, y: paddingForTexts, width: cell.frame.width - cell.musicImage.frame.width - 10, height: cell.frame.height/2-paddingForTexts)
        cell.musicArtist.frame = CGRect(x: cell.musicImage.frame.maxX + 10, y: cell.frame.height/2, width: cell.frame.width - cell.musicImage.frame.width - 10, height: cell.frame.height/2-paddingForTexts)
        cell.loadingBar.frame = CGRect(x: 0, y: 0, width: 0, height: cell.frame.height)
        cell.waitingBar.frame = CGRect(x: 0, y: cell.frame.height-2, width: cell.frame.width, height: 2)
        cell.selectionStyle = .none
        
    }
    
    
    
}

extension DownloadViewController {
    
    //MARK:- download
    
    fileprivate func startDownloading(_ cell: SearchResultTableViewCell, _ searchResult: SearchResult) {
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
                
            } else {
                
                //TODO:- change it
                //Helper.shared.alert(UIApplication.topViewController() ?? self, title: "", body: "Download failed.")
                
            }
            
            self.isDownloading = false
            cell.isDownloading = false
            
        }
    }
    
    fileprivate func handleDownload(_ tableView: UITableView, _ indexPath: IndexPath) {

        var isDownloaded = false
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell else {return}
        let searchResult = self.searchResults[indexPath.row]
        
        helper.getRecentlyDownloadedMusics { (tracks) in
            let ids = tracks.map {$0.track_id}
            let matchedId = ids.filter {$0 == "\(searchResult.id)"}
            
            isDownloaded = !matchedId.isEmpty
            
        }
        
//        if isDownloaded {
//            helper.alert(self, title: "💾", body: "شما این موزیک را دانلود کرده اید. ")
//        } else {
        
            if !isDownloading {
                
                startDownloading(cell, searchResult)
                
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
            
            
//        }
        
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
            self.searchResultTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
            //self.searchSuggestionsTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.searchBar.frame.origin.y = view.frame.height - helper.getTabBarHeight() - 50
        self.searchResultTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
        //self.searchSuggestionsTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
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
        searchResultTableView.isHidden = false
        searchSuggestionsTableView.isHidden = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text == "" {
            self.searchResults.removeAll()
            self.searchResultTableView.reloadData()
        }
        
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    fileprivate func searchFor(_ text: String) {
        startIndicator()
        API.search(text: text) { (success, searchResultArray) in
            self.searchResults = searchResultArray
            self.searchResultTableView.reloadData()
            self.stopIndicator()
        }
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
    private var isDownloading : Bool = false
    
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
        searchSuggestionsTableView.frame = CGRect(x: 10, y: logo.frame.maxY , width: view.frame.width-20, height: view.frame.height/2)
        
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















