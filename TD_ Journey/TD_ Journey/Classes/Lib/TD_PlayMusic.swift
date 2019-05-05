//
//  TD_PlayMusic.swift
//  TD_KnockIce
//
//  Created by mac on 2018/7/19.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit
import AVFoundation

class TD_PlayMusic: SKNode {

    
    func playMusic(musicName:String){
        let backgroundMusicURL = Bundle.main.url(forResource: musicName, withExtension: nil)
        
        let theme = try! AVAudioPlayer(contentsOf: backgroundMusicURL!)
//            if !GameScene.backgroundMusicPlayer.isPlaying {
        theme.play()
    }
}
