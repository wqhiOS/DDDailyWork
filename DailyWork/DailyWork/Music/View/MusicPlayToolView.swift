//
//  MusicPlayView.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class MusicPlayToolView: UIView {
    
    static let shared = MusicPlayToolView()
    
    var musicInfo: MusicInfo? {
        didSet {
            guard let musicInfo = musicInfo else {
                return
            }
            titleLabel.text = musicInfo.title
            
            subTitleLabel.text = musicInfo.author! + "-" + musicInfo.album_title!
            
            durationLable.text = "\(musicInfo.bitrate?.file_duration ?? 0)"
            
            musicImageView.kf.setImage(with: URL(string: musicInfo.pic_big ?? ""))
         
        }
    }
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage(named: "Music_SusClose"), for: .normal)
        btn.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        return btn
    }()
    private lazy var titleLabel = UILabel(font: UIFont.pingFangSCMediumAndSize(15), textColorHex: "ffffff")
    
    private lazy var durationLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFangSCRegularAndSize(13)
        label.textColor = UIColor.init(white: 1, alpha: 0.7)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pingFangSCRegularAndSize(13)
        label.textColor = UIColor.init(white: 1, alpha: 0.7)
        return label
    }()
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private lazy var progressButton: MusicProgressButton = {
        let btn = MusicProgressButton.init(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        btn.addTarget(self, action: #selector(progressButtonClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    deinit {
        print("musicPlayView-deinit")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(animated: Bool) {
        if self.superview != nil {
            self.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview().offset(-60)
                make.width.equalTo(SCREEN_WIDTH-30)
                make.centerX.equalToSuperview()
                make.height.equalTo(55)
            }
            if animated == true {
                UIView.animate(withDuration: 0.4) {
                    self.superview?.layoutIfNeeded()
                }
            }else {
                self.superview?.layoutIfNeeded()
            }
            
        }
    }
    func dismiss(animated: Bool) {
        if self.superview != nil {
            self.snp.remakeConstraints { (make) in
                make.top.equalTo(self.superview!.snp.bottom)
                make.width.equalTo(SCREEN_WIDTH-30)
                make.centerX.equalToSuperview()
                make.height.equalTo(55)
            }
            if animated == true {
                UIView.animate(withDuration: 0.4) {
                    self.superview?.layoutIfNeeded()
                }
            }else {
                self.superview?.layoutIfNeeded()
            }
        }
    }
    
   
    @objc private func closeButtonClick() {
        dismiss(animated: false)
    }
    @objc private func progressButtonClick(_ btn: MusicProgressButton) {
        btn.isSelected = !btn.isSelected
        
        if btn.isSelected == true {//暂停
            DDAudioPlayer.shared.pause()
        }else {
            DDAudioPlayer.shared.play()
        }

        closeButton.snp.updateConstraints { (make) in
            make.width.height.equalTo(btn.isSelected ? 35 : 0)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    @objc private func click() {
        
        let musicPlayVc = MusicPlayViewController()
        musicPlayVc.music = musicInfo
        musicPlayVc.modalPresentationStyle = .custom
        musicPlayVc.transitioningDelegate = MusicTransitionAnimation.shared
        var currentVc = UIApplication.shared.keyWindow?.rootViewController
        while ((currentVc?.presentedViewController) != nil) {
            currentVc = currentVc?.presentedViewController
        }
        currentVc?.present(musicPlayVc, animated: true, completion: nil)

    }
    
    private func setupUI () {
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(click))
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
        
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        
        backgroundColor = UIColor.init(white: 0, alpha: 0.65)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(musicImageView)
        addSubview(progressButton)
        
        closeButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(0)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(closeButton.snp.right).offset(0)
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalTo(titleLabel)
        }
        musicImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(45)
            make.centerY.equalToSuperview()
        }
        progressButton.snp.makeConstraints { (make) in
            make.center.equalTo(musicImageView)
            make.width.height.equalTo(45)
        }
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        window.addSubview(self)
        self.snp.remakeConstraints { (make) in
            make.top.equalTo(window.snp.bottom)
            make.width.equalTo(SCREEN_WIDTH-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        window.layoutIfNeeded()
    }
    
}

extension MusicPlayToolView: DDAudioPlayerDelegate {
    func audioPlayerTimeChanged(currentTime: TimeInterval, totalTime: TimeInterval, audioModel: DDAudioModel, percent: Double) {
        progressButton.progress = percent
    }
}
