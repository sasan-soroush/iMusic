////
////  AppDelegateGoogleSignIn.swift
////  iMusic
////
////  Created by New User on 12/30/18.
////  Copyright © 2018 sasan soroush. All rights reserved.
////
//
//import UIKit
//import GoogleSignIn
//
//extension AppDelegate {
//    
//    GIDSignIn.sharedInstance.signIn(
//       with: signInConfig,
//       presenting: self
//   ) { user, error in
//       guard error == nil else { return }
//       guard let user = user else { return }
//
//       // Your user is signed in!
//   }
//    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//
//        if error != nil {
//            print(error.localizedDescription)
//        } else {
//            print("successfull")
//            /*let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
//            */
//            
//            let vc = mainTabBarController
//            vc.modalPresentationStyle = .fullScreen
//            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
//
//        }
//    }
//    
//    
//    func setupGoogleSignIn() {
////        GIDSignIn.sharedInstance.delegate = self
//        GIDConfiguration.init(clientID: "1097840637672-mn9gc39tcu4rhampacr4me1epolirb84.apps.googleusercontent.com")
//    }
//    
//    func application(_ application: UIApplication,
//                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return GIDSignIn.sharedInstance.handle(url,
//                                                 sourceApplication: sourceApplication,
//                                                 annotation: annotation)
//    }
//    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
//        var handled: Bool
//        
//        handled = GIDSignIn.sharedInstance.handle(url)
//        if handled {
//            return true
//        }
//        
//        // Handle other custom URL types.
//        
//        // If not handled by this app, return false.
//        return false
//    }
//    
//    
//}
