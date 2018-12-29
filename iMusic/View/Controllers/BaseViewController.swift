//
//  BaseViewController.swift
//  iMusic
//
//  Created by New User on 12/29/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

class BaseViewControllerTypeOne : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func setupView() {
        self.view.backgroundColor = UIColor.init(rgb: 0x202123)
        self.view.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0x266762), secondColor: UIColor.clear)
    }
    
}
