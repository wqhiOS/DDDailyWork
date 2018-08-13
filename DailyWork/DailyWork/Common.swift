//
//  Common.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import Foundation

/// 屏幕宽度 高度
let SCREEN_WIDTH:CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
let SCREEN_HEIGHT:CGFloat = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)

/// 判断是否iphoneX
let IS_IPHONEX = UIScreen.main.bounds.size.height == 812 ? true : false

/// 状态栏高度
let STATUS_BAR_HEIGHT: CGFloat = IS_IPHONEX ? (20 + 24) : 20

/// 导航栏高度
let NAVIGATION_BAR_HEIGHT: CGFloat = 44

let STATUS_AND_NAVIGATION_BAR_HEIGHT: CGFloat = STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT

infix operator %
public func % (left:CGFloat, right:CGFloat) -> CGFloat {
    return left.truncatingRemainder(dividingBy: right)
}
