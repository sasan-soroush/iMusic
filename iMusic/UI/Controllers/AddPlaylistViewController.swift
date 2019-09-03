//
//  AddPlaylistViewController.swift
//  iMusic
//
//  Created by New User on 9/3/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension AddPlaylistViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
}

extension AddPlaylistViewController {
    
    private func setupView() {
        
        self.logo.isHidden = true
        
    }
    
}

class AddPlaylistViewController : BaseViewControllerPresented {
    override init(initialY: CGFloat) {
        super.init(initialY: initialY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
