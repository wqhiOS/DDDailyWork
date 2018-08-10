//
//  MusicPlayViewController.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class MusicPlayViewController: BaseViewController {
    
   
    
    let songId: String
    var music: MusicInfo? {
        didSet {
            guard let music = music else {
                return
            }
            musicImageView.kf.setImage(with: URL(string: (music.pic_premium) ?? ""))
            musicNameLabel.text = music.title
            authorNameLabel.text = music.author
            endTimeLabel.text = "\(String(describing: music.bitrate?.file_duration ?? 0))"
        }
    }
    
    private lazy var backButton:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage(named: "BackButton"), for: .normal)
        btn.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return btn
    }()
    private lazy var musicImageViewCover: UIView = {
        let cover = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.6, height: SCREEN_WIDTH*0.6))
        cover.backgroundColor = UIColor.white
        cover.layer.shadowColor = UIColor.black.cgColor
        cover.layer.shadowOffset = CGSize(width: 2, height: 5)
        cover.layer.shadowOpacity = 0.4
        cover.layer.shadowRadius = 10

        return cover
    }()
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView.init()
        
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        return imageView
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider.init()
        slider.maximumTrackTintColor = UIColor.hex("EEEEEE")
        slider.minimumTrackTintColor = UIColor.hex("03C37D")
        return slider
    }()
    private lazy var musicNameLabel = UILabel.init(font: UIFont.pingFangSCMediumAndSize(16), textColorHex: "333333", textAlignment: .center)
    private lazy var authorNameLabel = UILabel.init(font: UIFont.pingFangSCRegularAndSize(14), textColorHex: "666666", textAlignment: .center)
    private lazy var startTimeLabel = UILabel.init(font: UIFont.pingFangSCRegularAndSize(12), textColorHex: "999999", textAlignment: .center, text: "00:00")
    private lazy var endTimeLabel = UILabel.init(font: UIFont.pingFangSCRegularAndSize(12), textColorHex: "999999", textAlignment: .center)
    private lazy var preButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "Music_AudioPre"), for: .normal)
        btn.addTarget(self, action: #selector(preButtonClick(_:)), for: .touchUpInside)
        return btn
    }()
    private lazy var nextButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "Music_AudioNext"), for: .normal)
        btn.addTarget(self, action: #selector(nextButtonClick(_:)), for: .touchUpInside)
        return btn
    }()
    private lazy var playButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "Music_AudioPlay"), for: .normal)
        btn.setImage(UIImage(named: "Music_AudioPause"), for: .selected)
        btn.addTarget(self, action: #selector(playButtonClick(_:)), for: .touchUpInside)
        return btn
    }()
    private lazy var audioListButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "Music_AudioList"), for: .normal)
        btn.addTarget(self, action: #selector(audioListButtonClick(_:)), for: .touchUpInside)
        return btn
    }()
    private lazy var likeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "Music_like"), for: .normal)
        btn.setImage(UIImage(named: "Music_liked"), for: .selected)
        btn.addTarget(self, action: #selector(likeButtonClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    init(_ musicId: String) {
        songId = musicId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        queryMusicInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MusicPlayToolView.shared.dismiss(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MusicPlayToolView.shared.musicInfo = music
        MusicPlayToolView.shared.show(animated: true)
    }
    
    private func queryMusicInfo() {
        MusicHandle.queryMusicInfo(songId, success: { (music) in
            self.music = music
        }) { (errorMsg) in
            
        }
    }
    

}

// MARK: - PlayMusic
extension MusicPlayViewController {
    private func play() {
        let audioModel = DDAudioModel()
        audioModel.audioUrl = music?.bitrate?.file_link
        DDAudioPlayer.shared.playAudioImmediately([audioModel])
    }
    private func pause() {
        DDAudioPlayer.shared.pause()
    }
}

// MARK: - Action
extension MusicPlayViewController {
    @objc private func playButtonClick(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected == false {//暂停
            musicImageViewCover.layer.shadowOffset = CGSize(width: 2, height: 5)
            musicImageViewCover.layer.shadowOpacity = 0.4
            musicImageView.snp.updateConstraints { (make) in
                make.width.height.equalTo(SCREEN_WIDTH*0.6)
            }
            pause()
        }else {//播放
            musicImageViewCover.layer.shadowOffset = CGSize(width: 4, height: 8)
            musicImageViewCover.layer.shadowOpacity = 0.8
            musicImageView.snp.updateConstraints { (make) in
                make.width.height.equalTo(SCREEN_WIDTH*0.8)
            }
            play()
        }
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc private func preButtonClick(_ btn: UIButton) {
        
    }
    @objc private func nextButtonClick(_ btn: UIButton) {
        
    }
    @objc private func audioListButtonClick(_ btn: UIButton) {
        
    }
    @objc private func likeButtonClick(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
    }
    @objc private func backButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MAKR: - UI
extension MusicPlayViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(backButton)
        view.addSubview(musicImageViewCover)
        view.addSubview(musicImageView)
        view.addSubview(slider)
        view.addSubview(startTimeLabel)
        view.addSubview(endTimeLabel)
        view.addSubview(musicNameLabel)
        view.addSubview(authorNameLabel)
        view.addSubview(preButton)
        view.addSubview(playButton)
        view.addSubview(nextButton)
        view.addSubview(audioListButton)
        view.addSubview(likeButton)
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(44)
            make.top.equalToSuperview().offset(STATUS_BAR_HEIGHT)
        }
        
        musicImageViewCover.snp.makeConstraints { (make) in
            make.left.equalTo(musicImageView).offset(5)
            make.right.equalTo(musicImageView).offset(-5)
            make.top.equalTo(musicImageView).offset(5)
            make.bottom.equalTo(musicImageView).offset(-5)
        }

        musicImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(84)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(SCREEN_WIDTH*0.6)
        }
        
        slider.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(SCREEN_WIDTH*0.8 + 100)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        musicNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        authorNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(musicNameLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        startTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(slider.snp.left)
            make.top.equalTo(slider.snp.bottom)
        }
        endTimeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(slider.snp.right)
            make.top.equalTo(slider.snp.bottom)
        }
        playButton.snp.makeConstraints { (make) in
            make.top.equalTo(authorNameLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        preButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(playButton)
            make.right.equalTo(playButton.snp.left).offset(-80)
        }
        nextButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(playButton)
            make.left.equalTo(playButton.snp.right).offset(80)
        }
        audioListButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-20)
        }
        likeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(40)
            make.centerY.equalTo(audioListButton)
        }
   
        
    }
}
