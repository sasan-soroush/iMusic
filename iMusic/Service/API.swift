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
    typealias urlHandler = (Bool , URL?) -> ()
    typealias progressHandler = (CGFloat) -> ()
    
    //MARK:- methods -- Get
    //MARK:- search
    static func search(text : String , completion : @escaping searchResultHandler ) {
        
        let url = Urls.search(text: text)
        let header = helper.getHeader()
        
        Alamofire.request( url , method:.get , encoding: JSONEncoding.default , headers : header).validate()
            .responseJSON { response in
                
                if(response.result.isSuccess){
                    
                    guard let data = response.data else {return}
                    
                    do {
                        let searchResults = try
                            JSONDecoder().decode([SearchResult].self, from: data)
                        
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
    static func download(id : Int , progHandler : @escaping progressHandler, completion : @escaping urlHandler ) {
        
        
        let url = Urls.download
        let header = helper.getHeader()
        
        let params : [String : Any] = [
            "id"  :  id,
            "ext" : "mp3"
        ]
        
        let fileUrl = self.getSaveFileUrl(fileName: "music\(id).mp3")

        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(
            url,
            method: .post,
            parameters: params,
            headers: header,
            to: destination).downloadProgress(closure: { (progress) in
                                
                let prog = CGFloat(progress.fractionCompleted*100)
                progHandler(prog)
                
            }).response(completionHandler: { (DefaultDownloadResponse) in
                
                
                if let filePath = DefaultDownloadResponse.destinationURL {
                    
                    completion(true , filePath)
                    
                    
                    
//                    Player.playAudio(url: filePath)
                    
                } else {
                    completion(false,nil)
                    
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


















