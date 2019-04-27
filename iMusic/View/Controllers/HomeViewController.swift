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
        setup_view(cell)
        cell.musicTrack = self.downloadedMusics[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = self.downloadedMusics[indexPath.row]
        let id  = track.track.id
        let filePath = helper.getSaveFileUrl(musicId: id)
        helper.pandoraPlay(fromTabBar: true, target: self, filePath: filePath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (recentlyPlayedCV.frame.width - padding*2) / 3
        return CGSize(width: size , height: size * 1.5 - 5)
    }
    
    fileprivate func setup_view(_ cell: RecentlyPlayedCollectionViewCell) {
        let padding : CGFloat = 2
        cell.cover.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.width)
        
        cell.cover.roundCorners(corners: [.topLeft , .topRight], radius: 4)
//        cell.cover.layer.cornerRadius = 4
        
        cell.clipsToBounds = true
        
        cell.titleBackground.frame = CGRect(x: 0, y: cell.cover.frame.maxY , width: cell.frame.width, height: cell.frame.height - cell.frame.width)
        
        //        cell.titleBackground.layer.cornerRadius = 4
        
        cell.titleBackground.clipsToBounds = true
        
        cell.titleBackground.roundCorners(corners: [.bottomLeft , .bottomRight], radius: 5)
        
        let labelsHeight = (cell.titleBackground.frame.height)/2
        
        cell.artistLabel.frame = CGRect(x: 3 + padding , y: 4, width: cell.titleBackground.frame.width-6, height: labelsHeight-4)
        
        cell.titleLabel.frame = CGRect(x: 3 + padding , y: cell.artistLabel.frame.maxY , width: cell.titleBackground.frame.width-6, height: labelsHeight-4)
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
        recentlyPlayedCV.frame = CGRect(x: padding, y: self.logo.frame.maxY+padding, width: view.frame.width - padding*2, height: view.frame.height - self.logo.frame.maxY - padding - 52)
        
        /*view.addSubview(searchButton)
        let searchButtonWidth = recentlyPlayedCV.frame.minY - 20 - 10
        searchButton.frame = CGRect(x: view.frame.width - searchButtonWidth - 10, y: 20, width: searchButtonWidth, height: searchButtonWidth)*/
        
        
    }
}

class HomeViewController : BaseViewControllerNormal {
    
    let padding : CGFloat = 7
    var downloadedMusics : [MusicTrack] = []

    let recentlyPlayedCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        layout.scrollDirection = .vertical
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    /*let searchButton : UIButton = {
        let button = UIButton()
        let padding : CGFloat = 14
        button.setImage(#imageLiteral(resourceName: "magnifier").withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        button.addTarget(self, action: #selector(presentDownloadVC), for: UIControlEvents.touchUpInside)
        return button
    }()*/
    
}






