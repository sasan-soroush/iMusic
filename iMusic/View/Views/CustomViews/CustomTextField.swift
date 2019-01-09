//
//  CustomTextField.swift
//  iMusic
//
//  Created by New User on 1/5/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
    var placeHolder_ = ""
    init(frame: CGRect = .zero , placeHolder : String) {
        super.init(frame: frame)
        placeHolder_ = placeHolder
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray , NSAttributedStringKey.font : Font.IranYekanLight(size: 18)])
        textAlignment = .center
        tintColor = UIColor.MyTheme.themeBlueColor
        keyboardType = .numberPad
        keyboardAppearance = .dark
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
