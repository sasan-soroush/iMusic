//
//  PlaylistCollectionViewCell.swift
//  iMusic
//
//  Created by New User on 8/31/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class PlaylistCollectionViewCell : UICollectionViewCell {
    
    static let id = "PlaylistCollectionViewCellID"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.22)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
