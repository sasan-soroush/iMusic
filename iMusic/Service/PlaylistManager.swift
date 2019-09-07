//
//  PlaylistManager.swift
//  iMusic
//
//  Created by New User on 9/7/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import Foundation

class PlaylistManager {
    
    static private var playlists = [String:[String]]()
    
    static func createPlaylist() {
        playlists["ss"] = ["ads","awr"]
        playlists["aa"] = ["aaaa" , "bbbb"]
        print("SS")
        print(playlists["ss"])
        print("AA")
        print(playlists["aa"])
    }
    
    static func deletePlaylist(id : String) {
        
    }
    
    static func add(song : String , toPlaylist : String) {
        
    }
    
    static func remove(song : String , fromPlaylist : String) {
        
    }
    
}
