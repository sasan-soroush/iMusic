//
//  SearchSuggestionCell.swift
//  iMusic
//
//  Created by New User on 8/27/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//


import UIKit

class SearchSuggestionCell : UITableViewCell {
    
    static let id = "SearchSuggestionCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: SearchResultTableViewCell.id)
        backgroundColor = .clear
        addSubview(line)
        addSubview(suggestion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    let suggestion : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensedRegular(size: 19))
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.75)
        return label
    }()
   
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    
}
