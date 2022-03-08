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
import AVFoundation

class API {
    
    static var request: Alamofire.Request?

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
                        
                        var searchResults = try JSONDecoder().decode([SearchResult].self, from: data)
                        for i in 0 ..< searchResults.count {
                            helper.getRecentlyDownloadedMusics { (tracks) in
                                let ids = tracks.map {$0.track_id}
                                let matchedId = ids.filter {$0 == "\(searchResults[i].id)"}
                                searchResults[i].isDownloaded = !matchedId.isEmpty
                            }
                        }
                        
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
    static func download(downloadItem : SearchResult, progHandler : @escaping progressHandler, completion : @escaping urlHandler ) {
        
        let url = Urls.download
        let header = helper.getHeader()
        let id = downloadItem.id
        
        let params : [String : Any] = [
            "id"  :  id,
            "ext" : "mp3"
        ]
        
        let fileUrl = helper.getSaveFileUrl(musicId: id)

        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        request = Alamofire.download(
            url,
            method: .post,
            parameters: params,
            headers: header,
            to: destination).downloadProgress(closure: { (progress) in
                                
                let prog = CGFloat(progress.fractionCompleted*100)
                progHandler(prog)
                
            }).response(completionHandler: { (DefaultDownloadResponse) in
                
                let statusCode = DefaultDownloadResponse.response?.statusCode
                
                if statusCode == 200 || statusCode == 201 {
                    
                    if let filePath = DefaultDownloadResponse.destinationURL {
                        
                        //TODO:- maybe date needs some work
                        
                        var image_data : Data?
                        
                        let playerItem = AVPlayerItem(url: filePath)
                        let metadataList = playerItem.asset.metadata
                        
                        for item in metadataList {
                            
                            if let key = item.commonKey {
                                if key.rawValue  == "artwork" {
                                    if let audioImage = item.value as? Data  {
                                        image_data = audioImage
                                    }
                                }
                            }
                            
                        }
                        
                        let downloadedMusic = MusicTrack( track_id : "\(id)" , track: downloadItem, address: filePath, downloadDate: Date().currentTimeMillis() , cover : image_data  )
                        
                        helper.saveDownloadedMusics(music: downloadedMusic)
                        
                        completion(true , filePath)
                        
                        
                    } else {
                        
                        completion(false,nil)
                        
                    }
                } else {
                    completion(false,nil)
                }
                
                
            })
        
    }
}


















