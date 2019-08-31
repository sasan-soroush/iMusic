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
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubview(playlistImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let playlistImage : CustomImageView = {
        let view = CustomImageView()
        view.image = #imageLiteral(resourceName: "Screen Shot 2019-04-27 at 5.30.32 PM")
        return view
    }()
}
