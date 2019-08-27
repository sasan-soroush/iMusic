//
//  BaseViewController.swift
//  iMusic
//
//  Created by New User on 1/12/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

class BaseViewController : UIViewController {
    
    let constants = Consts.shared
    let helper = Helper.shared
    
    private func setupView() {
        self.view.backgroundColor = UIColor.MyTheme.backgroundColor
        let logoSize = logo.sizeThatFits(CGSize(width: 200, height: 50))
        self.view.addSubview(logo)
        
        logo.frame = CGRect(x: view.frame.width/2 - logoSize.width/2, y: 20, width: logoSize.width, height: view.frame.height/12)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent 
    }
    
    func startIndicator() {
        indicator.startAnimating()
    }
    
    func stopIndicator() {
        indicator.stopAnimating()
    }
    
    lazy var indicator : NVActivityIndicatorView = {
        let size : CGFloat = 40
        let frame = CGRect(x: self.view.frame.midX - size/2 , y: self.view.frame.height/3 - size/2, width: size, height: size)
        let indic = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.init(rawValue: 14) , color: UIColor.white, padding: 0)
        return indic
    }()
    
    let logo : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 30))
        label.text = "iMusic"
        return label
    }()
    
}

