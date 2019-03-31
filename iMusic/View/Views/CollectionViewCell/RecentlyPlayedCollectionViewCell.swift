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
                    
//                    self.titleBackground.backgroundColor = UIColor.init(red: 0 , green: 255/255, blue: 234/255, alpha: 0.45)
                    let color_1 = UIColor.init(red: 0 , green: 255/255, blue: 234/255, alpha: 0.0)
                    let color_2 = UIColor.init(red: 0 , green: 255/255, blue: 234/255, alpha: 0.5)
                    self.titleBackground.setGradientBackgroundColor(firstColor: color_1, secondColor: color_2)
//                    self.titleBackground.alpha = 0.7
//                    if image?.averageColor?.isDarkColor ?? true {
                    
                          self.artistLabel.textColor = .white
                          self.titleLabel.textColor = .white
                    
                    
//                    } else {
                    
//                        self.artistLabel.textColor = .black
//                        self.titleLabel.textColor = .darkGray
//
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
        let label = CustomLabel(customFont: Font.DINCondensed(size: 17))
        label.textAlignment = .left
        return label
    }()
    
    let artistLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 17))
        label.textAlignment = .left
        return label
    }()
    
    let titleBackground : UIView = {
        let view = UIView()
        return view
    }()
}
