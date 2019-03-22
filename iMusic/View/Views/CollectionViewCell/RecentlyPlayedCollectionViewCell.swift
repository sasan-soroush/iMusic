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
                
                self.cover.sd_setImage(with: URL(string: music.track.cover)) { (image , error, _, _) in
                    self.titleBackground.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
                    
//                    if image?.averageColor?.isDarkColor ?? true {
                        self.titleLabel.textColor = .white
                        self.artistLabel.textColor = .white
//                    } else {
//                        self.titleLabel.textColor = .black
//                        self.artistLabel.textColor = .black
//                    }
                    
                    
                }
                self.titleLabel.text = music.track.title
                self.artistLabel.text = music.track.artistName
                
            }
        }
    }
    
    static let id = "RecentlyPlayedCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cover)
        addSubview(titleBackground)
        titleBackground.addSubview(titleLabel)
        titleBackground.addSubview(artistLabel)
        clipsToBounds = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cover : CustomImageView = {
        let view = CustomImageView()
//        view.layer.cornerRadius = 4
        view.clipsToBounds = true
//        view.roundCorners(corners: [.topLeft , .topRight], radius: 8)
        return view
    }()
    
    let titleLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 16))
        return label
    }()
    
    let artistLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 16))
        return label
    }()
    
    let titleBackground : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
}
