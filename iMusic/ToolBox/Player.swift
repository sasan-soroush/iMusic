//
//  Player.swift
//  iMusic
//
//  Created by Sasan Soroush on 1/17/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import AVFoundation

class Player {
    
    private static var player: AVAudioPlayer?
    
    static func playAudio (url:URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)*/
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
