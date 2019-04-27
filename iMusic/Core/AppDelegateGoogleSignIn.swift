//
//  AppDelegateGoogleSignIn.swift
//  iMusic
//
//  Created by New User on 12/30/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit
import GoogleSignIn
extension AppDelegate : GIDSignInDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if error != nil {
            print(error.localizedDescription)
        } else {
            print("successfull")
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            UIApplication.topViewController()?.present(mainTabBarController, animated: true, completion: nil)

        }
    }
    
    
    func setupGoogleSignIn() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "1097840637672-mn9gc39tcu4rhampacr4me1epolirb84.apps.googleusercontent.com"
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    
}
