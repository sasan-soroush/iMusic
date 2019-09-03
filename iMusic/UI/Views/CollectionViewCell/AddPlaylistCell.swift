//
//  AddPlaylistCell.swift
//  iMusic
//
//  Created by New User on 9/3/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

class AddPlaylistCell : UICollectionViewCell {
    
    static let id = "AddPlaylistCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.22)
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubview(plusImage)
    }
    
    let plusImage : CustomImageView = {
        let view = CustomImageView()
        view.image = #imageLiteral(resourceName: "plus").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        view.tintColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

