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
    
    static let shared = DDAudioPlayer.init()
    
    var player: AVPlayer?
    var currentPlayerItem: AVPlayerItem?
    var currentAudioModel: DDAudioModel?
    
    var audioList:[DDAudioModel]?
    
    
    func stopAudio() {
        self.player?.currentItem?.cancelPendingSeeks()
        self.player?.currentItem?.asset.cancelLoading()
        self.player = nil
        
    }

    
    private func setupMediaSession() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try? AVAudioSession.sharedInstance().setActive(true)

    }
}

// MAKR: - public method
extension DDAudioPlayer {
    func playAudioImmediately(_ audioArray:[DDAudioModel],index:Int = 0) {
        setupMediaSession()
        audioList?.removeAll()
        if (self.audioList?.count ?? 0) > 0 {
            stopAudio()
        }
        audioList = audioArray
        self.currentAudioModel = audioList?[index]
        
        guard let cAudioModel = self.currentAudioModel,
            let audioUrl = cAudioModel.audioUrl?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: audioUrl) else {
                return
        }
        
        
        let playerItem = AVPlayerItem(url: url)
        self.currentPlayerItem = playerItem
        
        if self.player != nil {
            self.player?.replaceCurrentItem(with: self.currentPlayerItem)
        }else {
            self.player = AVPlayer.init(playerItem: self.currentPlayerItem)
        }
        self.player?.play()
        
    }
    func pause() {
        
        guard let currentPlayer = player else {
            return
        }
        if currentPlayer.rate <= 0 {
            return
        }
        currentPlayer.pause()
    }
}
