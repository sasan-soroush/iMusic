//
//  API.swift
//  iMusic
//
//  Created by New User on 1/5/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API {
    
    static let helper = Helper.shared

    typealias stringHandler  = (Bool , String) -> ()
    typealias normalHandler  = (Bool) -> ()
    typealias imageHandler  = (Bool , UIImage?) -> ()
    typealias searchResultHandler  = (Bool , [SearchResult]) -> ()
    typealias completionHadnler = () -> ()
    
    
    //MARK:- methods -- Get
    //MARK:- search
    static func search(text : String , completion : @escaping searchResultHandler ) {
        
        let url = Urls.search(text: text)
        let header = helper.getHeader()
        
        Alamofire.request( url , method:.get , encoding: JSONEncoding.default , headers : header).validate()
            .responseJSON { response in
                
                if(response.result.isSuccess){
                    
//                    print(JSON(response.result.value!))
                    guard let data = response.data else {return}
                    do {
                        let searchResults = try JSONDecoder().decode([SearchResult].self, from: data)
                        completion(true , searchResults)
                    } catch {
                        completion(false , [])
                    }
                    
                } else {
                    helper.handleError(response: response)
                    completion(false , [])
                }
                
        }
        
    }
    
    //MARK:- download
    static func download(id : Int ,cell : SearchResultTableViewCell , completion : @escaping searchResultHandler ) {
        
        cell.waitingBar.startAnimating()
        
        let url = Urls.download
        let header = helper.getHeader()
        
        let params : [String : Any] = [
            "id"  :  id,
            "ext" : "mp3"
        ]

        let fileUrl = self.getSaveFileUrl(fileName: "music\(id)")
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(
            url,
            method: .post,
            parameters: params,
            headers: header,
            to: destination).downloadProgress(closure: { (progress) in
                
                let prog : CGFloat = CGFloat(progress.fractionCompleted*100)
                cell.waitingBar.stopAnimating()
                cell.loadingBar.isHidden = false
                cell.loadingBar.frame = CGRect(x: 0, y: cell.frame.height-3, width: cell.frame.width/100 * (prog), height: 3)
            }).response(completionHandler: { (DefaultDownloadResponse) in
                
                cell.waitingBar.stopAnimating()
                cell.loadingBar.isHidden = true
                if let filePath = DefaultDownloadResponse.destinationURL {
                    Player.playAudio(url: filePath)
                } else {
                    helper.alert(UIApplication.topViewController() ?? DownloadViewController(), title: "", body: "Download failed.")
                }
                
            })
        
    }
    
    static func getSaveFileUrl(fileName: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        NSLog(fileURL.absoluteString)
        return fileURL;
    }
}


















