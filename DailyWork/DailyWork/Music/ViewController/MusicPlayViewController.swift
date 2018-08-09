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
    var music: Music? {
        didSet {
            musicImageView.kf.setImage(with: URL(string: (music?.pic_premium) ?? ""))
            musicNameLabel.text = music?.title
            authorNameLabel.text = music?.author
        }
    }
    
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.layer.cornerRadius = SCREEN_WIDTH * 0.6 * 0.5
        imageView.layer.masksToBounds = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(back))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    private lazy var musicNameLabel = UILabel.init(font: UIFont.pingFangSCMediumAndSize(16), textColorHex: "333333", textAlignment: .center)
    private lazy var authorNameLabel = UILabel.init(font: UIFont.pingFangSCRegularAndSize(14), textColorHex: "666666", textAlignment: .center)
    private lazy var startTimeLabel = UILabel.init(font: UIFont.pingFangSCRegularAndSize(12), textColorHex: "999999", textAlignment: .center, text: "00:00")
    private lazy var endTimeLabel = UILabel.init(font: UIFont.pingFangSCRegularAndSize(12), textColorHex: "999999", textAlignment: .center)
    
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
    
    private func queryMusicInfo() {
        MusicHandle.queryMusicInfo(songId, success: { (music) in
            self.music = music
        }) { (errorMsg) in
            
        }
    }

    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(musicImageView)
        view.addSubview(musicNameLabel)
        view.addSubview(authorNameLabel)
        
        musicImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(SCREEN_WIDTH*0.6)
        }
        
    }
    
    @objc private func back() {
        self.dismiss(animated: true, completion: nil)
    }

}
