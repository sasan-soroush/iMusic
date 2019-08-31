//
//  PlaylistRow.swift
//  iMusic
//
//  Created by New User on 8/31/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit


class PlaylistRowCell : UITableViewCell {
    
    static let id = "PlaylistRowCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: ProfileTableViewCell.id)
        backgroundColor = .clear
        addSubview(playlistsCV)
        playlistsCV.backgroundColor = .clear
        playlistsCV.delegate = self
        playlistsCV.dataSource = self
        playlistsCV.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: PlaylistCollectionViewCell.id)
        playlistsCV.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    let playlistsCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = false
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return view
    }()
}

extension PlaylistRowCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistCollectionViewCell.id, for: indexPath) as! PlaylistCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.height), height: (frame.height))
    }
}


