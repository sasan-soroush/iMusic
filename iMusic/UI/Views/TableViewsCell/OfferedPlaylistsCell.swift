//
//  OfferedPlaylistsCell.swift
//  iMusic
//
//  Created by New User on 8/31/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class OfferedPlaylistsCell : UITableViewCell {
    
    static let id = "OfferedPlaylistsCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: ProfileTableViewCell.id)
        backgroundColor = .clear
        addSubview(offersCV)
        offersCV.delegate = self
        offersCV.dataSource = self
        offersCV.register(PaymentPlanCollectionViewCell.self, forCellWithReuseIdentifier: PaymentPlanCollectionViewCell.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let offersCV : UICollectionView = {
        let layout = HSCycleGalleryViewLayout()
        let pager = UICollectionView(frame: .zero, collectionViewLayout: layout)
        pager.backgroundColor = .clear
        return pager
    }()
    
}

extension OfferedPlaylistsCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentPlanCollectionViewCell.id, for: indexPath) as! PaymentPlanCollectionViewCell
        cell.backgroundColor = UIColor.white.withAlphaComponent(1)
        return cell
    }
    
}
