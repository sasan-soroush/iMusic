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
import Disk

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
    //MARK:- show alert without option
    func alert(_ controller:UIViewController, title:String, body:String){
        
        let alertController = UIAlertController(title: title, message:body, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        controller.present(alertController, animated: true, completion: nil)
        
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
        } catch {
            print(error)
        }
        
        completion(downloadedMusics)
    }
    
    //MARK:- save downlaoded music
    
    func saveDownloadedMusics(music : MusicTrack) {
        
        do {
            
            try Disk.append(music, to: Consts.shared.downloadedMusicsKey, in: Disk.Directory.documents)
            
        } catch {
            print(error)
        }
        
    }
    
    //MARK:- path finder
    
    func pathFor(name: String, fileType: String) -> String {
        let bundle = Bundle(for: type(of: self));
        let path = bundle.path(forResource: name, ofType: fileType)!;
        return path;
    }
    
    //MARK:- save file url
    
    func getSaveFileUrl(fileName: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        NSLog(fileURL.absoluteString)
        return fileURL;
    }
}
