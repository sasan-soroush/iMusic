//
//  RecentlyPlayedCollectionViewCell.swift
//  iMusic
//
//  Created by New User on 2/3/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit
import SDWebImage

class RecentlyPlayedCollectionViewCell : UICollectionViewCell {
    
    var musicTrack : MusicTrack? {
        didSet {
            if let music = musicTrack {
                
                self.cover.sd_setImage(with: URL(string: music.track.cover), completed: nil)
                self.titleLabel.text = music.track.title
                self.artistLabel.text = music.track.artistName
                
            }
        }
    }
    
    static let id = "RecentlyPlayedCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cover)
        addSubview(titleLabel)
        addSubview(artistLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cover : CustomImageView = {
        let view = CustomImageView()
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensedRegular(size: 16))
        return label
    }()
    
    let artistLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensedRegular(size: 16))
        return label
    }()
}
