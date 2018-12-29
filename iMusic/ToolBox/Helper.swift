//
//  Helper.swift
//  iMusic
//
//  Created by New User on 12/29/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

class Helper  {
    
    static let shared = Helper()
    
    func getMiddleYAxisPoint(up_y : CGFloat , down_y : CGFloat , height : CGFloat) -> CGFloat {
        let distance = down_y - up_y
        let middlePoint = up_y + distance/2
        let heightOfAmountTF = height
        let startingPointInYAxis = middlePoint - heightOfAmountTF/2
        return startingPointInYAxis
    }
}
