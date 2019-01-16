//
//  Urls.swift
//  iMusic
//
//  Created by New User on 1/16/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class Urls {
    
    static let shared = Urls()
    
    static let base = Consts.shared.baseUrl
    
    static func getSearch(text : String) -> String {
        return base + "search?query=\(text)&limit=10"
    }
    
}
