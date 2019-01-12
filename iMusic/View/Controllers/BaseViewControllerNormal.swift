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
        self.view.setGradientBackgroundColor(firstColor: UIColor.MyTheme.gradientForBGColor, secondColor: UIColor.clear)
        self.view.bringSubview(toFront: logo)
    }
}







