//
//  CustomImageView.swift
//  iMusic
//
//  Created by New User on 1/16/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class CustomImageView : UIImageView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFit
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
