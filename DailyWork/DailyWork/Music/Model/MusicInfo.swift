//
//  Song.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import Foundation
import HandyJSON

struct MusicInfo:HandyJSON {
    
    var song_id: String?
    var title: String?
    var author: String?
    var album_title: String?
    var artist_name: String?
    
    var pic_big: String?
    var pic_small: String?
    var publishtime: String?
    var pic_radio: String?
    var pic_s500: String?
    var pic_huge: String?
    var pic_premium: String?
    var album_500_500: String?
    var album_800_800: String?
    var album_1000_1000: String?
    
    var bitrate: MusicBitrate?
    
}
