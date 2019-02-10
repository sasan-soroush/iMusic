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
        let cellPadding : CGFloat = 10
        let labelsHeight = (cell.frame.height - ( cell.frame.width - cellPadding * 2))/2
        
        cell.cover.frame = CGRect(x: cellPadding, y: 0, width: cell.frame.width - cellPadding*2, height: cell.frame.width - cellPadding*2)
        
        cell.artistLabel.frame = CGRect(x: 0, y: cell.cover.frame.maxY+3, width: cell.frame.width, height: labelsHeight-3)
        
        cell.titleLabel.frame = CGRect(x: 0, y: cell.artistLabel.frame.maxY, width: cell.frame.width, height: labelsHeight)
        
        cell.musicTrack = self.downloadedMusics[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filePath = self.downloadedMusics[indexPath.row].address
        print(filePath.absoluteString)
        if filePath.absoluteString != "" {
            let asset = AVAsset(url: filePath )
            let item = AVPlayerItem(asset: asset)
            let playerVC = PandoraPlayer.configure(withPath: filePath.absoluteString)
            self.navigationController?.present(playerVC, animated: true, completion: nil)
        }
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
    
    let recentlyPlayedCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        return view
    }()
    
}






