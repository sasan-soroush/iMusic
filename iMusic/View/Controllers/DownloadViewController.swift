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
        
        
    }
}

class DownloadViewController : BaseViewControllerPresented {
    
    private func setupView() {
        
        view.addSubview(searchBar)
        
        searchBar.frame = CGRect(x: 10, y: view.frame.height - 50, width: view.frame.width - 20, height: 40)
        
        if let txfSearchField = searchBar.value(forKey: "_searchField") as? UITextField {
            txfSearchField.borderStyle = .none
            txfSearchField.backgroundColor = UIColor.MyTheme.textFieldBG
            txfSearchField.layer.cornerRadius = 8
            txfSearchField.clipsToBounds = true
            searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
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
        bar.placeholder = "Search something amazing"
        return bar
    }()
    
}


