//
//  SearchResultTableViewCell.swift
//  iMusic
//
//  Created by New User on 1/12/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultTableViewCell : UITableViewCell {
    
    var searchResult : SearchResult?{
        didSet {
            guard let result = searchResult else {return}
            musicArtist.text = result.artistName
            musicName.text = result.title
            musicImage.sd_setImage(with: URL(string: result.cover) , placeholderImage: nil, options: SDWebImageOptions.progressiveDownload, completed: nil)
        }
    }
    
    static let id = "SearchBarTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: SearchResultTableViewCell.id)
        backgroundColor = .clear
        addSubview(line)
        addSubview(musicImage)
        addSubview(musicName)
        addSubview(musicArtist)
        addSubview(loadingBar)
        addSubview(waitingBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let musicArtist : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensedRegular(size : 19))
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        return label
    }()
    
    let musicName : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 21))
        label.textAlignment = .left
        return label
    }()
    
    let musicImage : CustomImageView = {
        let image = CustomImageView()
        image.contentMode = UIViewContentMode.scaleAspectFit
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    let waitingBar : HorizontalProgressbar = {
        let bar = HorizontalProgressbar()
        bar.progressTintColor = .white
        return bar
    }()
    
    let loadingBar : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.isHidden = true
        return view
    }()
}
