//
//  PaymentPlansTableViewCell.swift
//  iMusic
//
//  Created by New User on 4/28/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class PaymentPlansTableViewCell : UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource  {
    
    static let id = "PaymentPlansTableViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: PaymentPlansTableViewCell.id)
        backgroundColor = .clear
        
        addSubview(paymentPlans)
        paymentPlans.register(PaymentPlanCollectionViewCell.self, forCellWithReuseIdentifier: PaymentPlanCollectionViewCell.id)
        paymentPlans.delegate = self
        paymentPlans.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let paymentPlans : UICollectionView = {
        let layout = HSCycleGalleryViewLayout()
        let pager = UICollectionView(frame: .zero, collectionViewLayout: layout)
        pager.backgroundColor = .clear
        return pager
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentPlanCollectionViewCell.id, for: indexPath) as! PaymentPlanCollectionViewCell
        return cell
    }
    
}
