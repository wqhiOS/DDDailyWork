//
//  DDAudioPlayer.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit
import AVKit


/// 音频播放器 状态
///
/// - error: 发生错误
/// - playing: 播放中
/// - paused: 暂停
/// - stop: 结束
enum DDAudioPlayerStatus {
    case error
    case playing
    case paused
    case stop
}

/// DDAudioPlayerDelegate
protocol DDAudioPlayerDelegate:NSObjectProtocol {
    
    /// 当前播放时间发生改变，UI根据此协议方法更新界面,更换进度
    ///
    /// - Parameters:
    ///   - currentTime: 音频当前播放到的时间
    ///   - totalTime: 音频总时长
    ///   - audioModel: 音频模型
    ///   - percent: 音频已播百分比
    func audioPlayerTimeChanged(currentTime: TimeInterval,totalTime: TimeInterval, audioModel: DDAudioModel,percent: Double)
}



/// 播放器player
class DDAudioPlayer: NSObject {
    
    static let shared = DDAudioPlayer.init()
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var playerStatus: DDAudioPlayerStatus = .stop
    var audioModel: DDAudioModel?
    var currentAudioTime: Double = 0
    
    var audioList:[DDAudioModel]?
    
    var delegates = [DDAudioPlayerDelegate]()
    
    private var timer: Timer?
    
    
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

extension DDAudioPlayer {
    private func startTimer(){
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0/2.0, target: self, selector: #selector(timerPlay), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
        
    }
    private func stopTimer() {
        guard let currentTimer = timer else {
            return
        }
        if currentTimer.isValid {
            currentTimer.invalidate()
        }

    }
    @objc private func timerPlay() {
        guard let currentPlayer = player,
            let currentItem = currentPlayer.currentItem,
            let currentAudioModel = self.audioModel else {
            return
        }
        currentAudioTime = CMTimeGetSeconds(currentPlayer.currentTime())
        let totalTime = CMTimeGetSeconds(currentItem.duration)
        let percent = currentAudioTime/totalTime
        
        if currentPlayer.status == .readyToPlay {
            self.delegates.forEach({ (delegate) in
                delegate.audioPlayerTimeChanged(currentTime: currentAudioTime, totalTime: totalTime, audioModel: currentAudioModel, percent: percent)
            })
        }
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
        self.audioModel = audioList?[index]
        
        guard let cAudioModel = self.audioModel,
            let audioUrl = cAudioModel.audioUrl?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: audioUrl) else {
                return
        }
        
        let asset = AVAsset.init(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        self.playerItem = playerItem
        
        if self.player != nil {
            self.player?.replaceCurrentItem(with: self.playerItem)
        }else {
            self.player = AVPlayer.init(playerItem: self.playerItem)
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
        timer?.fireDate = Date.distantFuture
        currentPlayer.pause()
    }
    func play() {
        guard let currentPlayer = player else {
            return
        }
        timer?.fireDate = Date()
        currentPlayer.play()
    }
}

// MARK: - KVO
extension DDAudioPlayer {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let item = object as? AVPlayerItem else{
            return
        }
        if item != self.playerItem {
            return
        }
        switch item.status {
        case .readyToPlay:
            print("readyToPlay")
            
            self.playerStatus = .playing
            if #available(iOS 10.0, *) {
                self.player?.playImmediately(atRate: 1.0)
            }else {
                self.player?.play()
            }
            startTimer()

        case .failed:
            print("failed")
        case .unknown:
            print("unknown")
        }
    }

}
