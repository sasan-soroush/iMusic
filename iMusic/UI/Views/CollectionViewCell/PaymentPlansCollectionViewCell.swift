//
//  PaymentPlansCollectionViewCell.swift
//  iMusic
//
//  Created by New User on 4/28/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class PaymentPlanCollectionViewCell : UICollectionViewCell {
    
    static let id = "PaymentPlanCollectionViewCell"
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
