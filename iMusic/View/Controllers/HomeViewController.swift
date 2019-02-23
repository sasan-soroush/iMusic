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
    
    @objc private func presentDownloadVC() {
        let downloadVC = DownloadViewController()
        let presentedNav = UINavigationController(rootViewController: downloadVC)
        presentedNav.modalPresentationStyle = .overCurrentContext
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let tabBar = delegate.mainTabBarController
        tabBar.present(presentedNav, animated: true, completion: {
            downloadVC.searchBar.becomeFirstResponder()
        })
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedMusics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCollectionViewCell.id, for: indexPath) as! RecentlyPlayedCollectionViewCell
        
        cell.cover.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.width)
        
        cell.titleBackground.frame = CGRect(x: cell.cover.frame.minX, y: cell.cover.frame.height/3*2, width: cell.cover.frame.width, height: cell.cover.frame.height/3)
        
        let labelsHeight = cell.titleBackground.frame.height/2-3
        
        cell.artistLabel.frame = CGRect(x: 3, y: 3, width: cell.titleBackground.frame.width-6, height: labelsHeight-3)
        
        cell.titleLabel.frame = CGRect(x: 3, y: cell.artistLabel.frame.maxY, width: cell.titleBackground.frame.width-6, height: labelsHeight)
        cell.musicTrack = self.downloadedMusics[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: NSNotification.Name.init(constants.notificationName_BeforePlayingNewMusic), object: nil)
        
        let id  = self.downloadedMusics[indexPath.row].track.id
        let filePath = helper.getSaveFileUrl(musicId: id)
        
        let asset = AVAsset(url: filePath )
        let item = AVPlayerItem(asset: asset)
        let playerVC = PandoraPlayer.configure(withAVItems: [item])
        self.navigationController?.present(playerVC, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: recentlyPlayedCV.frame.width/2 - padding/2 , height: recentlyPlayedCV.frame.width/2 - padding/2)
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
        
        view.addSubview(searchButton)
        let searchButtonWidth = recentlyPlayedCV.frame.minY - 20 - 10
        searchButton.frame = CGRect(x: view.frame.width - searchButtonWidth - 10, y: 20, width: searchButtonWidth, height: searchButtonWidth)
        
        
    }
}

class HomeViewController : BaseViewControllerNormal {
    
    let padding : CGFloat = 7
    var downloadedMusics : [MusicTrack] = []
    fileprivate var musicPlayer: EZAudioPlayer!

    let recentlyPlayedCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        layout.scrollDirection = .vertical
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let searchButton : UIButton = {
        let button = UIButton()
        let padding : CGFloat = 14
        button.setImage(#imageLiteral(resourceName: "magnifier").withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        button.addTarget(self, action: #selector(presentDownloadVC), for: UIControlEvents.touchUpInside)
        return button
    }()
    
}






