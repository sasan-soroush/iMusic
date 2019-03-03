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
        mainTabBarController = ESTabBarController()
        mainTabBarController.delegate = self
        mainTabBarController.title = "Irregularity"
        mainTabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        mainTabBarController.tabBar.backgroundImage = #imageLiteral(resourceName: "tab bar")
        
        /*mainTabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        mainTabBarController.didHijackHandler = {
            [weak mainTabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                let downloadVC = DownloadViewController()
                let presentedNav = UINavigationController(rootViewController: downloadVC)
                presentedNav.modalPresentationStyle = .overCurrentContext
                
                mainTabBarController?.present(presentedNav, animated: true, completion: {
                    downloadVC.searchBar.becomeFirstResponder()
                })
            }
        }*/
        
        let v1 = UINavigationController(rootViewController: PlayListViewController())
        let v2 = UINavigationController(rootViewController: HomeViewController())
        //let v3 = UINavigationController(rootViewController: HomeViewController())
        let v4 = UINavigationController(rootViewController: HomeViewController())
        let v5 = UINavigationController(rootViewController: HomeViewController()) 
        
        v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "خانه", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "پلی لیست", image: #imageLiteral(resourceName: "playlist"), selectedImage: #imageLiteral(resourceName: "playlist_1"))
        //v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: #imageLiteral(resourceName: "download"), selectedImage: #imageLiteral(resourceName: "download"))
        v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "اخبار", image: #imageLiteral(resourceName: "news"), selectedImage: #imageLiteral(resourceName: "news_1"))
        v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "پروفایل", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        mainTabBarController.viewControllers = [v1, v2, v4, v5]
        
        let navigationController_signedIn = UINavigationController(rootViewController: mainTabBarController)
        
        
        let navigationController_signedOut = UINavigationController(rootViewController: SignUpViewController())
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
             self.window?.rootViewController = navigationController_signedIn
        } else {
             self.window?.rootViewController = navigationController_signedOut
        }
       
    }
}
