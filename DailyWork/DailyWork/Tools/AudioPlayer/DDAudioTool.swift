//
//  DDAudioTool.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/13.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit



class DDAudioTool {
    
    static func dealTimeWithVideoTime(videoTime: Double) -> String{
        if videoTime < 0 {
            return ""
        }
        let time = Int(videoTime)
        let s: Int = time % 60
        let m: Int = time / 60 % 60
        let h: Int = time / 60 / 60
        if videoTime > 3600 {
            return String(format: "%02zu:%02zu:%02zu", h,m,s)
        }else {
            return String(format: "%02zu:%02zu", m,s)
        }
        
    }
    
//    //时间处理
//    -(NSString *)dealTimeWithVideoTime:(Float64 )videoTime{
//    if (videoTime < 0) {
//    return @"";
//    }
//    NSUInteger time = (NSInteger)videoTime;
//    NSUInteger s = time % 60;
//    NSUInteger m = time / 60 % 60;
//    NSUInteger h = time / 60 / 60;
//    if (videoTime >= 3600) {
//    return [NSString stringWithFormat:@"%02zu:%02zu:%02zu", h, m, s];
//    }
//    else {
//    return [NSString stringWithFormat:@"%02zu:%02zu", m, s];
//    }
//    }

}
