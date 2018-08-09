//
//  DDAudioPlayer.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit
import AVKit

class DDAudioPlayer: NSObject {
    
    var player: AVPlayer?
    var currentAudioItem: AVPlayerItem?
    var currentAudioModel: DDAudioModel?
    
    var audioList:[DDAudioModel]?
    
    func playAudioImmediately(_ audioArray:[DDAudioModel],index:Int = 0) {
        setupMediaSession()
        audioList?.removeAll()
        if (self.audioList?.count ?? 0) > 0 {
            stopAudio()
        }
        audioList = audioArray
        self.currentAudioModel = audioList?[index]
        
        guard let cAudioModel = self.currentAudioModel else {
            return
        }

        
    }
    func stopAudio() {
        self.player?.currentItem?.cancelPendingSeeks()
        self.player?.currentItem?.asset.cancelLoading()
        self.player = nil
        
    }

    
    private func setupMediaSession() {
        
    }
}
