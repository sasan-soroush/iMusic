//
//  LabelTypeOne.swift
//  iMusic
//
//  Created by New User on 12/30/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

class CustomLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let customFont = UIFont(name: "D-DINCondensed-Bold", size: 35) else {return}
        font = UIFontMetrics.default.scaledFont(for: customFont)
        adjustsFontForContentSizeCategory = true
        textAlignment = .center
        textColor = .white
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
