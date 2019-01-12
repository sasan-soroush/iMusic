//
//  DownloadViewController.swift
//  iMusic
//
//  Created by New User on 1/9/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension DownloadViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addKeyboardNotifiactions()
        
    }
}

extension DownloadViewController {
    
    private func addKeyboardNotifiactions() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
//    sahab pardaz
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.searchBar.frame.origin.y -= keyboardSize.height
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.searchBar.frame.origin.y = view.frame.height - 50
        
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
}

class DownloadViewController : BaseViewControllerPresented {
    
    private func setupView() {
        
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 10, y: view.frame.height - 50, width: view.frame.width - 20, height: 40)
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 8, vertical: 0)
        
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
    
}


