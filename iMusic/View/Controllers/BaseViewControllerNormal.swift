//
//  BaseViewController.swift
//  iMusic
//
//  Created by New User on 12/29/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

extension BaseViewControllerNormal {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

class BaseViewControllerNormal : BaseViewController {
    
    private func setupView() {
        
        self.view.bringSubview(toFront: logo)
        
        let image_size = headerView.sizeThatFits(CGSize(width: view.frame.width, height: 200))
        
        self.view.addSubview(headerView)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: image_size.height)
        
    }
    
    let headerView : UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "Rectangle 16"))
        return view
    }()
}







