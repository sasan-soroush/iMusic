//
//  DownloadViewController.swift
//  iMusic
//
//  Created by New User on 1/9/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit
import AVFoundation
import ID3TagEditor
import MediaPlayer
import OutcastID3

extension DownloadViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addKeyboardNotifiactions()
        testtest()
    }
    
}

extension  DownloadViewController {
    
    func readTest(url: URL) throws {
        
        print(url.lastPathComponent)
        
        let x = try OutcastID3.MP3File(localUrl: url)
        
        let tag = try x.readID3Tag()
        self.outputTag(tag: tag.tag)
    }
    
    func outputTag(tag: OutcastID3.ID3Tag) {
        for frame in tag.frames {
            switch frame {
            case let s as OutcastID3.Frame.StringFrame:
                print("\(s.type.description): \(s.str)")
                
            case let u as OutcastID3.Frame.UrlFrame:
                print("\(u.type.description): \(u.urlString)")
                
            case let comment as OutcastID3.Frame.CommentFrame:
                print("COMMENT: \(comment)")
                
            case let transcription as OutcastID3.Frame.TranscriptionFrame:
                print("TRANSCRIPTION: \(transcription)")
                
            case let picture as OutcastID3.Frame.PictureFrame:
                print("PICTURE: \(picture)")
                
            case let f as OutcastID3.Frame.ChapterFrame:
                print("CHAPTER: \(f)")
                
            case let toc as OutcastID3.Frame.TableOfContentsFrame:
                print("TOC: \(toc)")
                
            case let rawFrame as OutcastID3.Frame.RawFrame:
                print("Unrecognised frame: \(String(describing: rawFrame.frameIdentifier))")
                
            default:
                break
            }
        }
    }
}

extension DownloadViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.id, for: indexPath) as! SearchResultTableViewCell
        
        setupCell(cell, indexPath)
        cell.searchResult = self.searchResults[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.height/8
        
    }
    
    fileprivate func setupCell(_ cell: SearchResultTableViewCell, _ indexPath: IndexPath) {
        
        let paddingForTexts : CGFloat = 10
        
        cell.line.frame = CGRect(x: 0, y: cell.frame.height - 0.5, width: cell.frame.width, height: 0.5)
        cell.musicImage.frame = CGRect(x: 0, y: 5, width: cell.frame.height-10, height: cell.frame.height-10)
        cell.musicName.frame = CGRect(x: cell.musicImage.frame.maxX + 10, y: paddingForTexts, width: cell.frame.width - cell.musicImage.frame.width - 10, height: cell.frame.height/2-paddingForTexts)
        cell.musicArtist.frame = CGRect(x: cell.musicImage.frame.maxX + 10, y: cell.frame.height/2, width: cell.frame.width - cell.musicImage.frame.width - 10, height: cell.frame.height/2-paddingForTexts)
        cell.loadingBar.frame = CGRect(x: 0, y: cell.frame.height-3, width: 0, height: 3)
        cell.waitingBar.frame = CGRect(x: 0, y: cell.frame.height-2, width: cell.frame.width, height: 2)
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*let cell = tableView.cellForRow(at: indexPath) as! SearchResultTableViewCell
        let id = self.searchResults[indexPath.row].id
        
        cell.waitingBar.startAnimating()
        API.download(id: id, progHandler : { (progress) in
            
            cell.waitingBar.stopAnimating()
            cell.loadingBar.isHidden = false
            cell.loadingBar.frame = CGRect(x: 0, y: cell.frame.height-3, width: cell.frame.width/100 * (progress), height: 3)
            
        }) { (success, filePath) in
            
            if success {
                cell.waitingBar.stopAnimating()
                cell.loadingBar.isHidden = true
                
                if filePath != nil {
                    
//                    let playerVC = PandoraPlayer.configure(withAVItem: item)
//                    self.navigationController?.present(playerVC, animated: true, completion: nil)
                }
                
                
            } else {
                Helper.shared.alert(UIApplication.topViewController() ?? DownloadViewController(), title: "", body: "Download failed.")
            }
            
        }*/
        
    }
    
    
    private func testtest() {
        let frames: [OutcastID3TagFrame] = [
            OutcastID3.Frame.StringFrame(type: .title, encoding: .utf8, str: "kos gholombe"),
            OutcastID3.Frame.StringFrame(type: .albumTitle, encoding: .utf8, str: "sasan soroush"),
            //try! OutcastID3.Frame.PictureFrame(encoding: String.Encoding.utf8, mimeType: "image/jpeg", pictureType: .coverFront, pictureDescription: "picture", picture: OutcastID3.Frame.PictureFrame.Picture(from : #imageLiteral(resourceName: "default_background") as! Decoder))
            //OutcastID3.Frame.PictureFrame(encoding: String.Encoding.utf8, mimeType: "image/jpeg", pictureType: OutcastID3.Frame.PictureFrame.PictureType.coverFront, pictureDescription: "picture", picture: OutcastID3.Frame.PictureFrame.Picture(from: ) )
        ]
        
        let tag = OutcastID3.ID3Tag(
            version: .v2_4,
            frames: frames
        )
        
        let inputUrl = Bundle.main.url(forResource: "Alan", withExtension: "mp3")!
        
        
        do {
            try readTest(url: inputUrl)
            let mp3File = try OutcastID3.MP3File(localUrl: inputUrl)

            let fileName = "Test"
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt.mp3")


            try mp3File.writeID3Tag(tag: tag, outputUrl: fileURL)
            let asset = AVAsset(url: fileURL)
            let item = AVPlayerItem(asset: asset)
            let playerVC = PandoraPlayer.configure(withAVItem: item)
            self.navigationController?.present(playerVC, animated: true, completion: nil)
        } catch let err {
            print(err)
        }
        
    }
    
    
    
    
    
//    private func addTagTo(musicUrl : URL?) {
//
//        let urlPath = Bundle.main.url(forResource: "Alan", withExtension: "mp3")
//
//        let imageData: Data = UIImagePNGRepresentation(#imageLiteral(resourceName: "default_background"))!
//        do {
//            let id3Tag = ID3Tag(
//                version: .version3,
//                artist: "an example artist",
//                albumArtist: "an example album artist",
//                album: "an example album",
//                title: "an example title",
//                recordingDateTime: RecordingDateTime(date: RecordingDate(day: 1, month: 10, year: 2019),
//                                                     time: RecordingTime(hour: 14, minute: 30)),
//                genre: Genre(genre: .ClassicRock, description: "Rock & Roll"),
//                attachedPictures: [AttachedPicture(picture: imageData, type: .FrontCover, format: .Jpeg)],
//                trackPosition: TrackPositionInSet(position: 2, totalTracks: 9)
//            )
//
//            try ID3TagEditor().write(tag: id3Tag, to: "<valid path to the mp3 file that will be overwritten>")
//            try ID3TagEditor().write(tag: id3Tag,
//            to: "<valid path to the mp3 file>",
//            andSaveTo: "<new path where you want to save the mp3>")
//            let newMp3: Data = try id3TagEditor.write(tag: id3Tag, mp3: <valid mp3 file passed as Data>)
//
//        } catch {
//            print(error)
//        }
//
//    }
    
    
    
    
    
    
    
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
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.searchBar.frame.origin.y = view.frame.height - 50
        self.searchResultTableView.frame = CGRect(x: 10, y: self.logo.frame.maxY , width: view.frame.width-20, height: self.searchBar.frame.minY - self.logo.frame.maxY - 10)
    }
    
}

extension DownloadViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else {
            Helper.shared.alert(self, title: "", body: "مشکلی با متن وارد شده وجود دارد.")
            return
        }
        
        API.search(text: text) { (success, searchResultArray) in
            self.searchResults = searchResultArray
            self.searchResultTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO:- search after 1 second delay
    }
}

class DownloadViewController : BaseViewControllerPresented {
    
    private var searchResults : [SearchResult] = []
    
    private func setupView() {
        
        
        view.addSubview(searchBar)
        view.addSubview(searchResultTableView)
        
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 10, y: view.frame.height - 50, width: view.frame.width - 20, height: 40)
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 8, vertical: 0)
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.id)
        searchResultTableView.separatorStyle = .none
        
        searchResultTableView.frame = CGRect(x: 10, y: logo.frame.maxY , width: view.frame.width-20, height: searchBar.frame.minY - logo.frame.maxY - 10)
        
        setupSearchBar()
        
    }
    
    private func setupSearchBar() {
        
        let cancelButtonAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        if let txtSearchField = searchBar.value(forKey: "_searchField") as? UITextField {
            txtSearchField.borderStyle = .none
            txtSearchField.backgroundColor = UIColor.MyTheme.textFieldBG
            txtSearchField.layer.cornerRadius = 8
            txtSearchField.clipsToBounds = true
            txtSearchField.keyboardAppearance = .dark
            let attributedString = NSAttributedString(string: "  نام اهنگ یا خواننده", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray , NSAttributedStringKey.font : Font.IranYekanLight(size: 18) ])
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
    
}















