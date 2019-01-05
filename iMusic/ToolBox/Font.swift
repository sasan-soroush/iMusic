//
//  Font.swift
//  iMusic
//
//  Created by New User on 12/30/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

class Font  {
    
    static func DINCondensed(size  : CGFloat) -> UIFont {
        let font = UIFont.init(name: "D-DINCondensed-Bold", size: size)
        return font!
    }
    
    static func AvenirTextUltraLight(size  : CGFloat) -> UIFont {
        let font = UIFont.init(name: "AvenirNext-UltraLight", size: size)
        return font!
    }
    
    static func AvenirTextRegular(size  : CGFloat) -> UIFont {
        let font = UIFont.init(name: "AvenirNext-Regular", size: size)
        return font!
    }
    
    static func IranYekanRegular(size  : CGFloat) -> UIFont {
        let font = UIFont.init(name: "IRANYekanMobileFaNum", size: size)
        return font!
    }
    
    static func IranYekanBold(size  : CGFloat) -> UIFont {
        let font = UIFont.init(name: "IRANYekanMobileFaNum-Bold", size: size)
        return font!
    }
    
    static func IranYekanLight(size  : CGFloat) -> UIFont {
        let font = UIFont.init(name: "IRANYekanMobileFaNum-Light", size: size)
        return font!
    }

    
}

