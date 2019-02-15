//
//  HomeViewController.swift
//  iMusic
//
//  Created by New User on 12/31/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit
import AVFoundation
import Disk
import AudioKit
import AVKit
import MediaPlayer



extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()


    }
    
    override func viewDidAppear(_ animated: Bool) {
        getDowloadedMusic()
    }
    
    private func getDowloadedMusic() {
        
        helper.getRecentlyDownloadedMusics { (musics) in
            self.downloadedMusics = musics
            recentlyPlayedCV.reloadData()
        }
        
    }
    
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedMusics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCollectionViewCell.id, for: indexPath) as! RecentlyPlayedCollectionViewCell
        
        cell.cover.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.width)
        
        cell.titleBackground.frame = CGRect(x: cell.cover.frame.minX, y: cell.cover.frame.midY, width: cell.cover.frame.width, height: cell.cover.frame.height/2)
        
        let labelsHeight = cell.titleBackground.frame.height/2-3
        
        cell.artistLabel.frame = CGRect(x: 3, y: 3, width: cell.titleBackground.frame.width-6, height: labelsHeight-3)
        
        cell.titleLabel.frame = CGRect(x: 0, y: cell.artistLabel.frame.maxY, width: cell.titleBackground.frame.width-6, height: labelsHeight)
        cell.musicTrack = self.downloadedMusics[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let id  = self.downloadedMusics[indexPath.row].track.id
        let filePath = helper.getSaveFileUrl(musicId: id)
        
        let asset = AVAsset(url: filePath )
        let item = AVPlayerItem(asset: asset)
        let playerVC = PandoraPlayer.configure(withAVItems: [item])
        self.navigationController?.present(playerVC, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: recentlyPlayedCV.frame.width/3 , height: recentlyPlayedCV.frame.height)
    }
    
    private func setupCV() {
        recentlyPlayedCV.delegate = self
        recentlyPlayedCV.dataSource = self
        recentlyPlayedCV.register(RecentlyPlayedCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyPlayedCollectionViewCell.id)
    }
}

extension HomeViewController {
    private func setupView() {
        
        setupCV()
        
        view.addSubview(recentlyPlayedCV)
        recentlyPlayedCV.frame = CGRect(x: padding, y: self.logo.frame.maxY+padding, width: view.frame.width - padding*2, height: view.frame.height/4.5)
        
        
    }
}

class HomeViewController : BaseViewControllerNormal {
    
    let padding : CGFloat = 10
    var downloadedMusics : [MusicTrack] = []
    fileprivate var musicPlayer: EZAudioPlayer!

    let recentlyPlayedCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        return view
    }()
    
}






