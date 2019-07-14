//
//  ProfileTableViewCell.swift
//  iMusic
//
//  Created by New User on 7/14/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit


class ProfileTableViewCell : UITableViewCell {
    
    static let id = "ProfileTableViewCellID"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: ProfileTableViewCell.id)
        backgroundColor = .clear
        addSubview(textField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textField : HoshiTextField = {
        let field = HoshiTextField()
        field.textAlignment = .right
        field.backgroundColor = .clear
        field.font = Font.IranYekanRegular(size: 18)
        field.textColor = .white
        field.placeholderColor = .lightGray
        field.borderInactiveColor = .lightGray
        field.borderActiveColor = .white
        field.keyboardAppearance = UIKeyboardAppearance.dark
        field.autocorrectionType = .no
        field.addDoneButton()
        return field
    }()
    
}

