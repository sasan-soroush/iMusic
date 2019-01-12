//
//  SearchResultTableViewCell.swift
//  iMusic
//
//  Created by New User on 1/12/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class SearchResultTableViewCell : UITableViewCell {
    
    static let id = "SearchBarTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: SearchResultTableViewCell.id)
        backgroundColor = .clear
        addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
}
