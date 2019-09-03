//
//  FollowedPlaylistCell.swift
//  iMusic
//
//  Created by New User on 9/3/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

protocol FollowedPlaylistsCellDelegate {
    func followPlaylistButtonTapped()
}

class FollowedPlaylistCell : UITableViewCell {
    
    static let id = "FollowedPlaylistCell"
    var addMode = false
    var delegate : FollowedPlaylistsCellDelegate?
    var playlists : [Playlist] = [] {
        didSet {
            addMode = (playlists.count == 0)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String? ) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: ProfileTableViewCell.id)
        backgroundColor = .clear
        addSubview(playlistsCV)
        playlistsCV.backgroundColor = .clear
        playlistsCV.delegate = self
        playlistsCV.dataSource = self
        playlistsCV.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: PlaylistCollectionViewCell.id)
        playlistsCV.register(AddPlaylistCell.self, forCellWithReuseIdentifier: AddPlaylistCell.id)
        playlistsCV.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let playlistsCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = false
        view.showsHorizontalScrollIndicator = false
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return view
    }()
}

extension FollowedPlaylistCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addMode ? 1 : playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if addMode {
            return handleAddMode(collectionView, indexPath)
        } else {
            return handleNormalMode(collectionView, indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if addMode {
            delegate?.followPlaylistButtonTapped()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.height), height: (frame.height))
    }
    
    fileprivate func handleAddMode(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPlaylistCell.id, for: indexPath) as! AddPlaylistCell
        let padding : CGFloat = cell.frame.width/3
        cell.plusImage.frame = CGRect(x: padding, y: padding, width: cell.frame.width - padding*2, height: cell.frame.height - padding*2)
        return cell
    }
    
    fileprivate func handleNormalMode(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistCollectionViewCell.id, for: indexPath) as! PlaylistCollectionViewCell
        return cell
    }
}
