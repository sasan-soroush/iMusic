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
        Helper.shared.getFontsList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    let logo : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 35))
        label.text = "iMusic"
        return label
    }()
    
    
    private func setupView() {
        self.view.backgroundColor = UIColor.init(rgb: 0x202123)
        self.view.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0x266762), secondColor: UIColor.clear)
        
        self.view.addSubview(logo)
        logo.frame = CGRect(x: view.frame.width/5*2, y: 20, width: view.frame.width/5, height: view.frame.height/12)
    }
    
}







