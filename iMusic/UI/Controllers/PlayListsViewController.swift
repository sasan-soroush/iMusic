//
//  FeaturedViewController.swift
//  iMusic
//
//  Created by New User on 2/26/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension PlayListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setDefaults()
        
    }
    
}


extension PlayListViewController {
    
    private func setupView() {
        
        view.addSubview(playlistsCV)
        playlistsCV.frame = CGRect(x: 0, y: view.frame.height/10, width: view.frame.width, height: view.frame.height/4)
        
    }
    
    private func setDefaults() {
        self.logo.isHidden = true
        playlistsCV.delegate = self
        playlistsCV.dataSource = self
        playlistsCV.register(PaymentPlanCollectionViewCell.self, forCellWithReuseIdentifier: PaymentPlanCollectionViewCell.id)
    }
    
}

extension PlayListViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentPlanCollectionViewCell.id, for: indexPath) as! PaymentPlanCollectionViewCell
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return cell
    }
    
}

class PlayListViewController : BaseViewControllerNormal {
    
    let playlistsCV : UICollectionView = {
        let layout = HSCycleGalleryViewLayout()
        let pager = UICollectionView(frame: .zero, collectionViewLayout: layout)
        pager.backgroundColor = .clear
        return pager
    }()
    
    
}
