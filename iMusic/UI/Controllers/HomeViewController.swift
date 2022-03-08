//
//  HomeViewController.swift
//  iMusic
//
//  Created by New User on 12/31/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit
import AVFoundation
//import Disk
import AudioKit
import AVKit
import MediaPlayer
//import DisplaySwitcher

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
            recentlyPlayedCV?.reloadData()
        }
        
    }
    
}

extension HomeViewController : OptionsDelegate {
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        if gesture.state != .began {
            return
        }
        
        let p = gesture.location(in: self.recentlyPlayedCV)
        
        if let indexPath = self.recentlyPlayedCV.indexPathForItem(at: p) {
            
            let vc = OptionsForTrackViewController(initialY: view.frame.height/3, track: self.downloadedMusics[indexPath.item])
            vc.delegate = self
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overCurrentContext
            self.navigationController?.present(nav, animated: true, completion: nil)
            
            
        } else {
            print("couldn't find index path")
        }
    }
    
    func deleted() {
        getDowloadedMusic()
    }
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedMusics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCollectionViewCell.id, for: indexPath) as! RecentlyPlayedCollectionViewCell
        
        if layoutState == .grid {
            setup_view_grid(cell)
        } else {
            setup_view_list(cell)
        }
        
        cell.musicTrack = self.downloadedMusics[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        return customTransitionLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let track = self.downloadedMusics[indexPath.row]
//        let id  = track.track.id
//        let filePath = helper.getSaveFileUrl(musicId: id)
//        helper.pandoraPlay(fromTabBar: true, target: self, filePath: filePath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTransitionAvailable = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isTransitionAvailable = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    fileprivate func setup_view_grid(_ cell: RecentlyPlayedCollectionViewCell) {
        
        let padding : CGFloat = 5
        cell.cover.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.width)
        
        //cell.cover.roundCorners(corners: [.topLeft , .topRight], radius: 4)
        
        cell.clipsToBounds = true
        
        cell.titleBackground.frame = CGRect(x: 0, y: cell.cover.frame.maxY , width: cell.frame.width, height: cell.frame.height - cell.frame.width)
        
        //cell.titleBackground.roundCorners(corners: [.bottomLeft , .bottomRight], radius: 5)
        
        let labelsHeight = (cell.titleBackground.frame.height)/2
        
        cell.artistLabel.frame = CGRect(x: 3 + padding , y: 4, width: cell.titleBackground.frame.width-6 - padding*2, height: labelsHeight-4)
        
        cell.titleLabel.frame = CGRect(x: 3 + padding , y: cell.artistLabel.frame.maxY , width: cell.titleBackground.frame.width - 6 - padding*2, height: labelsHeight-4)
        
        self.cover_size = cell.cover.frame.size.width
        
        cell.artistLabel.font = Font.DINCondensedRegular(size: 16.5)
        
        cell.titleLabel.font = Font.DINCondensedRegular(size: 16.5)
        
        cell.artistLabel.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.75)
    }
    
    fileprivate func setup_view_list(_ cell: RecentlyPlayedCollectionViewCell) {
        
        let padding : CGFloat = 10
        
        cell.cover.frame = CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height)
        
        //cell.cover.roundCorners(corners: [.topLeft , .bottomLeft], radius: 4)
        
        cell.clipsToBounds = true
        
        cell.titleBackground.frame = CGRect(x: cell.cover.frame.maxX, y: 0 , width: cell.frame.width - cell.cover.frame.width, height: cell.frame.height)
        
        //cell.titleBackground.roundCorners(corners: [.topRight , .bottomRight], radius: 5)
        
        let labelsHeight = (cell.titleBackground.frame.height)/2
        
        cell.titleLabel.frame = CGRect(x: 3 + padding , y: 10, width: cell.titleBackground.frame.width - 6 - padding*2, height: labelsHeight-10)
        
        cell.artistLabel.frame = CGRect(x: 3 + padding , y: cell.titleLabel.frame.maxY , width: cell.titleBackground.frame.width-6 - padding*2, height: labelsHeight-10)
        
        cell.artistLabel.font = Font.DINCondensedRegular(size: 18)
        
        cell.titleLabel.font = Font.DINCondensedRegular(size: 20)
        
        cell.artistLabel.textColor = .lightGray
        
    }
}

extension HomeViewController {
    private func setupView() {
        
        recentlyPlayedCV = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)
        recentlyPlayedCV.backgroundColor = .clear
        recentlyPlayedCV.showsVerticalScrollIndicator = false
        recentlyPlayedCV.delegate = self
        recentlyPlayedCV.dataSource = self
        recentlyPlayedCV.register(RecentlyPlayedCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyPlayedCollectionViewCell.id)
        
        view.addSubview(recentlyPlayedCV)
        recentlyPlayedCV.frame = CGRect(x: padding, y: self.logo.frame.maxY+padding, width: view.frame.width - padding*2, height: view.frame.height - self.logo.frame.maxY - padding - 52)
        
        recentlyPlayedCV.collectionViewLayout = gridLayout
        view.addSubview(rotationButton)
        let searchButtonWidth = recentlyPlayedCV.frame.minY - 20 - 10
        rotationButton.frame = CGRect(x: view.frame.width - searchButtonWidth - 10, y: 20, width: searchButtonWidth, height: searchButtonWidth)

        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        recentlyPlayedCV.addGestureRecognizer(lpgr)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        if downloadedMusics.isEmpty {
            return
        }
        
        self.rotationButton.isUserInteractionEnabled = false
        
        if !isTransitionAvailable {
            return
        }
        
        let animationDuration : Double = 0.3
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.recentlyPlayedCV.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.recentlyPlayedCV.alpha = 1
            }, completion: { (_) in
                self.rotationButton.isUserInteractionEnabled = true
            })
        }
        
        let transitionManager: TransitionManager
        if layoutState == .list {
            layoutState = .grid
            rotationButton.setImage(#imageLiteral(resourceName: "List"), for: UIControlState.normal)
            transitionManager = TransitionManager(duration: animationDuration, collectionView: recentlyPlayedCV, destinationLayout: gridLayout, layoutState: layoutState)
        } else {
            rotationButton.setImage(#imageLiteral(resourceName: "Grid"), for: UIControlState.normal)
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: recentlyPlayedCV, destinationLayout: listLayout, layoutState: layoutState)
        }
        
        transitionManager.startInteractiveTransition()

    }
}

class HomeViewController : BaseViewControllerNormal {
    
    var cover_size : CGFloat = 0.0
    let padding : CGFloat = 7
    var downloadedMusics : [MusicTrack] = []
    var recentlyPlayedCV : UICollectionView!
    var lastIndex : IndexPath?
    let deleteButton = UIButton(type: UIButtonType.system)
    let cancelButton = UIButton(type: UIButtonType.system)
    
    let rotationButton : PopBounceButton = {
        let button = PopBounceButton()
        let padding : CGFloat = 13
        button.setImage(#imageLiteral(resourceName: "List"), for: UIControlState.normal)
        button.imageEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    fileprivate var isTransitionAvailable = true
    private lazy var heightGrid = (view.frame.width - padding*4)/2
    private lazy var heighList = (view.frame.width - padding*4)/4
    private lazy var listLayout = DisplaySwitchLayout(staticCellHeight: heighList, nextLayoutStaticCellHeight: heightGrid, layoutState: .list)
    private lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: heightGrid, nextLayoutStaticCellHeight: heighList, layoutState: .grid)
    private var layoutState: LayoutState = .grid
    
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






