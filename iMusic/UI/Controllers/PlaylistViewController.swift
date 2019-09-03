//
//  PlaylistViewController.swift
//  iMusic
//
//  Created by New User on 9/3/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension PlaylistViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
}

extension PlaylistViewController {
    
    private func setupView() {
        
        self.logo.isHidden = false
        
    }
    
}

class PlaylistViewController : BaseViewControllerNormal {
    
}
