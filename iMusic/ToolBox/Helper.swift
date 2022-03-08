//
//  Helper.swift
//  iMusic
//
//  Created by New User on 12/29/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AVFoundation

class Helper  {
    
    static let shared = Helper()
    //MARK:- get middle y axis
    func getMiddleYAxisPoint(up_y : CGFloat , down_y : CGFloat , height : CGFloat) -> CGFloat {
        let distance = down_y - up_y
        let middlePoint = up_y + distance/2
        let heightOfAmountTF = height
        let startingPointInYAxis = middlePoint - heightOfAmountTF/2
        return startingPointInYAxis
    }
    //MARK:- get font list
    func getFontsList() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("--------------------------------------\n--------------------------------------")
            print("Family: \(family) Font names: \(names)")
            print("--------------------------------------\n--------------------------------------")
        }
    }
    //MARK:- handle server errors
    func handleError(response : DataResponse<Any> ) {
        
        let generalErrorMessage = "Something went wrong! Please check try again later !"
        guard let presenter = UIApplication.topViewController() else {return}
        if let data = response.data {
            do {
                let responseJSON = try JSON(data: data)
                let message: String = responseJSON["clientMsg"].stringValue
                if !message.isEmpty {
                        alert(presenter, title: "", body: message)
                } else {
                        alert(presenter, title: "" , body: generalErrorMessage)
                }
            } catch {
                    alert(presenter, title: "", body: generalErrorMessage)
            }
        }
        else {
                alert(presenter, title: "", body: generalErrorMessage)
        }
        switch response.response?.statusCode {
        case 401:
            break
        //TODO:- Force logout
        default:
            break
        }
    }
    
    func makeArrayOfSongs(StartWith : URL) -> [AVPlayerItem] {
        var playerItems : [AVPlayerItem] = []
        
        self.getRecentlyDownloadedMusics { (tracks) in
            
            let sortedTracks = tracks.sorted { $0.downloadDate > $1.downloadDate }
            let mappedTracks = sortedTracks.map {$0.track.id}
            var savedPaths = mappedTracks.map {self.getSaveFileUrl(musicId: $0)}
            savedPaths.insert(StartWith, at: 0)
            let assets = savedPaths.map {AVAsset(url: $0)}
            let items = assets.map {AVPlayerItem(asset: $0)}
            playerItems = items
        }
        
        return playerItems
        
    }
    
    func pandoraPlay(fromTabBar: Bool , target : UIViewController , filePath : URL) {
        NotificationCenter.default.post(name: NSNotification.Name.init(Consts.shared.notificationName_BeforePlayingNewMusic), object: nil)
        
        let items = makeArrayOfSongs(StartWith: filePath)
        let playerVC = PandoraPlayer.configure(withAVItems: items)
        playerVC.modalPresentationStyle = .overCurrentContext
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let tabBar = delegate.mainTabBarController
        if fromTabBar {
            tabBar.present(playerVC, animated: true, completion: nil)
        } else {
            target.navigationController?.present(playerVC, animated: true, completion: nil)
        }
        
    }
    
    //MARK:- show alert without option
    func alert(_ controller:UIViewController, title:String, body:String){
        
        let alertController = UIAlertController(title: title, message:body, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: nil)
        }
        //        controller.view.hideToastActivity()
    }
    
    //MARK:- get header for api requests
    
    func getHeader () -> [String : String] {
       
        let header : [String : String] = [
            "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1YzNmODFlNTFjMmJmMjQxMTZmY2M1ZWYiLCJpYXQiOjE1NDc2NjU4OTMsImV4cCI6MTU3OTIwMTg5M30.eV6J0G0tWhDEdU96MDG0Jq0Sl3hQugRQ81lsTV-dSzg"
        ]
        return header
    }
    
    //MARK:- get recent downloaded musics
    
    func getRecentlyDownloadedMusics(completion : ([MusicTrack])->()) {
        
        var downloadedMusics : [MusicTrack] = []
        
        do {
        
            downloadedMusics = try Disk.retrieve(Consts.shared.downloadedMusicsKey, from: .documents, as: [MusicTrack].self)
            
            for d in downloadedMusics {
                
                print(d.address)
                print(d.track.title)
                print(d.downloadDate)
                print("-__---__---__-")
                
            }
            
        } catch {
            print(error)
        }
        
        completion(downloadedMusics)
    }
    
    //MARK:- get tab bar height
    func getTabBarHeight() -> CGFloat {
        let tabBarImageView = UIImageView(image: #imageLiteral(resourceName: "Group 2"))
        let size = tabBarImageView.sizeThatFits(CGSize(width: UIScreen.main.bounds.size.width, height: 100))
        return size.height
    }
    
    //MARK:- save downlaoded music
    
    func saveDownloadedMusics(music : MusicTrack) {
        
        do {
            
            try Disk.append(music, to: Consts.shared.downloadedMusicsKey, in: Disk.Directory.documents)
            
        } catch {
            print(error)
        }
        
    }
    
    func deleteDownloadedMusics(music : MusicTrack , success : (Bool)->()) {
        do {
            let downloadedMusics = try Disk.retrieve(Consts.shared.downloadedMusicsKey, from: .documents, as: [MusicTrack].self)
            let filtered = downloadedMusics.filter {$0.track.id != music.track.id}
            try Disk.save(filtered, to: Disk.Directory.documents, as: Consts.shared.downloadedMusicsKey)
            success(true)
        } catch {
            success(false)
            print(error)
        }
    }
    
    func setProfileImage(image : UIImage) {
        do {
            try Disk.save(image, to: Disk.Directory.documents, as: Consts.shared.profileImage)
        } catch {
            print(error)
        }
    }
    
    func getProfilePicture() -> UIImage {
        var image = #imageLiteral(resourceName: "default_background")
        do {
            let img = try Disk.retrieve(Consts.shared.profileImage, from: Disk.Directory.documents, as: UIImage.self)
            image = img
        } catch {
            print(error)
        }
        return image
    }
    
    //MARK:- path finder
    
    func pathFor(name: String, fileType: String) -> String {
        let bundle = Bundle(for: type(of: self));
        let path = bundle.path(forResource: name, ofType: fileType)!;
        return path;
    }
    
    //MARK:- save file url
    
    func getSaveFileUrl(musicId: Int) -> URL {
        let fileName = "\(musicId).mp3"
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        NSLog(fileURL.absoluteString)
        return fileURL;
    }
}
