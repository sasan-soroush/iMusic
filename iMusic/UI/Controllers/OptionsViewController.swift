//
//  OptionsViewController.swift
//  iMusic
//
//  Created by New User on 9/3/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension OptionsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        if music != nil {
            if let imgData = music!.cover {
                if let image = UIImage(data: imgData) {
                    musicImage.image = image
                } else {
                    musicImage.sd_setImage(with: URL(string: music!.track.cover) , completed: nil)
                }
            } else {
                musicImage.sd_setImage(with: URL(string: music!.track.cover) , completed: nil)
            }
            
            musicName.text = music!.track.title
            musicArtist.text = music!.track.artistName
        }
        
        
        
    }
    
}

extension OptionsViewController {
    
    private func setupView() {
        
        let padding : CGFloat = 20
        let buttonWidth : CGFloat = (view.frame.width - padding*3)/3
        
        view.addSubview(shareButton)
        shareButton.frame = CGRect(x: padding, y: view.frame.height - helper.getTabBarHeight() - padding - buttonWidth*1.2, width: buttonWidth, height: buttonWidth*1.2)
        
        view.addSubview(addToPlaylistButton)
        addToPlaylistButton.frame = CGRect(x: shareButton.frame.maxX + padding/2, y: view.frame.height - helper.getTabBarHeight() - padding - buttonWidth*1.2, width: buttonWidth, height: buttonWidth*1.2)
        
        view.addSubview(deleteButton)
        deleteButton.frame = CGRect(x: addToPlaylistButton.frame.maxX + padding/2, y: view.frame.height - helper.getTabBarHeight() - padding - buttonWidth*1.2, width: buttonWidth, height: buttonWidth*1.2)
        
        view.addSubview(musicImage)
        musicImage.frame = CGRect(x: view.frame.width/5*2, y: topView.frame.maxY + padding, width: view.frame.width/5, height: view.frame.width/5)
        
        view.addSubview(musicName)
        musicName.frame = CGRect(x: padding*2, y: musicImage.frame.maxY + padding, width: view.frame.width - padding*4, height: 25)
        
        view.addSubview(musicArtist)
        musicArtist.frame = CGRect(x: padding*2, y: musicName.frame.maxY + padding/2, width: view.frame.width - padding*4, height: 25)
    }
    
}

class OptionsViewController : BaseViewControllerPresented {
    
    var music : MusicTrack?
    
    init(initialY: CGFloat , track : MusicTrack) {
        self.music = track
        super.init(initialY: initialY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let deleteButton : UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "DeleteTrack"), for: UIControlState.normal)
        return button
    }()
    
    let addToPlaylistButton : UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "AddToPlaylist"), for: UIControlState.normal)
        return button
    }()
    
    let shareButton : UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "SendToFriends"), for: UIControlState.normal)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        return button
    }()
    
    let musicName : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 21))
        label.textColor = .white
        return label
    }()
    
    let musicArtist : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensedRegular(size: 20))
        label.textColor = .white
        return label
    }()
    
    let musicImage : CustomImageView = {
        let view = CustomImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
}
