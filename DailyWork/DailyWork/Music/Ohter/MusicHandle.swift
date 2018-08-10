//
//  MusicHandle.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON
import HandyJSON

let songUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting"

class MusicHandle {
    
    static func queryMusicList(_ offset:Int,success:@escaping (([MusicInfo])->Void),failure:@escaping (String)->Void) {
        
        let paramters:Parameters = ["method":"baidu.ting.billboard.billList","type":1,"size":10,"offset":offset]
        getRequest(songUrl, parameters: paramters, success: { (json) in
            var songList = [MusicInfo]()

            let list = [MusicInfo].deserialize(from: json["song_list"].arrayObject)
            list?.forEach({ (song) in
                if let s = song {
                    songList.append(s)
                }
            })
        
            success(songList)
        }) { (error) in
            failure(error.localizedDescription)
        }
        
        
 
    }
    
    static func queryMusicInfo(_ songId:String,success:@escaping ((MusicInfo)->Void),failure:@escaping (String)->Void) {
        let paramters: Parameters = ["method":"baidu.ting.song.play","songid": songId]
        getRequest(songUrl, parameters: paramters, success: { (json) in
            
            if var music = MusicInfo.deserialize(from: json["songinfo"].dictionaryObject),let bitrate = MusicBitrate.deserialize(from: json["bitrate"].dictionaryObject) {
                music.bitrate = bitrate
                success(music)
            }else {
                failure("网络错误")
            }
            
        }) { (error) in
            failure(error.localizedDescription)
        }
    }
    
}
