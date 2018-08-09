//
//  UILabel+Extension.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//
import UIKit

extension UILabel {
    public convenience init(font: UIFont?, textColorHex: String,textAlignment: NSTextAlignment = .left,lines: Int = 1,text: String? = nil) {
        
//        self.textColor = UIColor.hex(textColorHex as NSString)
        
        self.init()
        self.font = font
        self.textColor = UIColor.hex(textColorHex as NSString)
        self.numberOfLines = lines
        self.textAlignment = textAlignment
        self.numberOfLines = lines
        self.text = text
        
        
    }
}
