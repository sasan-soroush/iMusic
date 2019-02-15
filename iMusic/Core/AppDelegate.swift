//
//  AppDelegate.swift
//  iMusic
//
//  Created by New User on 12/29/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit
import AudioKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UITabBarControllerDelegate{

    var window: UIWindow?
    var mainTabBarController = ESTabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupGoogleSignIn()
        setupApp()
        
        
        return true
    }
    
    
}

