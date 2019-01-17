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
    static func download(id : Int , completion : @escaping searchResultHandler ) {
        
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
//            encoding: JSONEncoding.default,
            headers: header,
            to: destination).downloadProgress(closure: { (progress) in
                //progress closure
                print(progress.fractionCompleted*100)
            }).response(completionHandler: { (DefaultDownloadResponse) in
                //here you able to access the DefaultDownloadResponse
                //result closure
                let filePath = DefaultDownloadResponse.destinationURL
                Player.playAudio(url: filePath!)
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


















