//
//  AppDelegateExtentions.swift
//  iMusic
//
//  Created by New User on 12/30/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//
import UIKit
import GoogleSignIn
extension AppDelegate{
   
    func setupApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        //        window?.rootViewController = UINavigationController(rootViewController: SignUpViewController())
        let tabBarController = ESTabBarController()
        tabBarController.delegate = self
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.tabBar.backgroundImage = #imageLiteral(resourceName: "tabbar_bg_dark")
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                alertController.addAction(takePhotoAction)
                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                alertController.addAction(selectFromAlbumAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                tabBarController?.present(alertController, animated: true, completion: nil)
            }
        }
        
        let v1 = UIViewController()
        let v2 = UIViewController()
        let v3 = UIViewController()
        let v4 = UIViewController()
        let v5 = UIViewController()
        
        v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Playlist", image: #imageLiteral(resourceName: "playlist"), selectedImage: #imageLiteral(resourceName: "playlist_1"))
        v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: #imageLiteral(resourceName: "download"), selectedImage: #imageLiteral(resourceName: "download"))
        v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "News", image: #imageLiteral(resourceName: "news"), selectedImage: #imageLiteral(resourceName: "news_1"))
        v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
        let navigationController_signedIn = UINavigationController(rootViewController: tabBarController)
        tabBarController.title = "Example"
        
        let navigationController_signedOut = UINavigationController(rootViewController: SignUpViewController())
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
             self.window?.rootViewController = navigationController_signedIn
        } else {
             self.window?.rootViewController = navigationController_signedOut
        }
       
    }
}
