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
    
    static func search(text : String , completion : @escaping searchResultHandler ) {
        
        let url = Urls.getSearch(text: text)
        let header = helper.getHeader()
        
        print(url)
        print(header)
        
        Alamofire.request( url , method:.get , encoding: JSONEncoding.default , headers : header).validate()
            .responseJSON { response in
                
                if(response.result.isSuccess){
                    
                    print(JSON(response.result.value!))
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
    
}


















