//
//  File.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import Foundation

struct MusicBitrate: HandyJSON {
    var song_file_id: Int?
    var file_size: Int?
    var file_extension: String?
    var file_duration: Int?
    var file_bitrate: Int?
    var file_link: String?
    var hash: String?
}
