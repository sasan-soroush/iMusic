//
//  BaseViewControllerTypeTwo.swift
//  iMusic
//
//  Created by New User on 1/9/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class BaseViewControllerTypeTwo : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        self.modalPresentationStyle = .overCurrentContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    let logo : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 30))
        label.text = "iMusic"
        return label
    }()
    
    let presentedView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        return view
    }()
    
    private func setupView() {
        view.addSubview(presentedView)
        presentedView.frame = CGRect(x: 0, y: 25, width: view.frame.width, height: view.frame.height)
        
        self.view.backgroundColor = UIColor.clear
        
        self.presentedView.setGradientBackgroundColor(firstColor: UIColor.clear , secondColor: UIColor.MyTheme.gradientForBGColor)
        let logoSize = logo.sizeThatFits(CGSize(width: 200, height: 50))
        self.view.addSubview(logo)
        
        logo.frame = CGRect(x: view.frame.width/2 - logoSize.width/2, y: 20, width: logoSize.width, height: view.frame.height/8)
    }
    
}
