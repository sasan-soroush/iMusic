//
//  Music.swift
//  iMusic
//
//  Created by New User on 1/5/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import Foundation

struct MusicTrack : Codable {
    let track : SearchResult
    let address : URL
    let downloadDate : Int64
}
