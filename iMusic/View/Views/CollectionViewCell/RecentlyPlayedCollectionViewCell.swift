//
//  RecentlyPlayedCollectionViewCell.swift
//  iMusic
//
//  Created by New User on 2/3/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit
import SDWebImage
import DisplaySwitcher

class RecentlyPlayedCollectionViewCell : UICollectionViewCell {
    
    var musicTrack : MusicTrack? {
        didSet {
            if let music = musicTrack {
                
                if let imgData = music.cover {
                    if let image = UIImage(data: imgData) {
                        cover.image = image
                    } else {
                        cover.sd_setImage(with: URL(string: music.track.cover) , completed: nil)
                    }
                } else {
                    cover.sd_setImage(with: URL(string: music.track.cover) , completed: nil)
                }
                
                self.titleLabel.text = music.track.title
                self.artistLabel.text = music.track.artistName
                
            }
        }
    }
    
    static let id = "RecentlyPlayedCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleBackground)
        addSubview(cover)
        
        titleBackground.addSubview(titleLabel)
        titleBackground.addSubview(artistLabel)
        
        clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    let cover : CustomImageView = {
        let view = CustomImageView()
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensedRegular(size: 16))
        label.textAlignment = .left
        return label
    }()
    
    let artistLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensedRegular(size: 16))
        label.textAlignment = .left
        
        return label
    }()
    
    let titleBackground : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.22)
        return view
    }()
}
