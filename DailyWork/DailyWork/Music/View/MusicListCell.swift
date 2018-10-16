//
//  SongListCell.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class MusicListCell: UITableViewCell {
    
    var music: MusicInfo? {
        didSet {
            guard let music = music else {
                return
            }
            picImageView.kf.setImage(with: URL.init(string: music.pic_radio ?? ""))
            songNameLabel.text = music.title
            authorLabel.text = music.author
        }
    }
    
    private lazy var picImageView:UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    private lazy var songNameLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.hex("333333")
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private lazy var authorLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.hex("333333")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(picImageView)
        addSubview(songNameLabel)
        addSubview(authorLabel)
        
        picImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.height.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        songNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picImageView.snp.right).offset(8)
            make.top.equalTo(picImageView).offset(12)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(songNameLabel)
            make.top.equalTo(songNameLabel.snp.bottom).offset(4)
        }
    }
    
}
