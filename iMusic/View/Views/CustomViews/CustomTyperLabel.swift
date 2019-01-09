//
//  CustomTyperLabel.swift
//  iMusic
//
//  Created by New User on 1/6/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class CustomTyperLabel: TypewriterLabel {
    
    init(customFont:UIFont) {
        super.init(frame: CGRect.zero)
        self.font = UIFontMetrics.default.scaledFont(for: customFont)
        adjustsFontForContentSizeCategory = true
        textAlignment = .center
        textColor = .white
        minimumScaleFactor = 0.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
