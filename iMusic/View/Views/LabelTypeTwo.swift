//
//  LabelTypeTwo.swift
//  iMusic
//
//  Created by New User on 12/30/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

class CustomLabel : UILabel {
    
    init(customFont:UIFont) {
        super.init(frame: CGRect.zero)
        self.font = UIFontMetrics.default.scaledFont(for: customFont)
        adjustsFontForContentSizeCategory = true
        textAlignment = .center
        textColor = .white
        minimumScaleFactor = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
