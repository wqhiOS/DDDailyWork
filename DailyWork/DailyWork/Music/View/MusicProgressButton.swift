//
//  MusicProgressButton.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class MusicProgressButton: UIButton {
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    
    var progress: Double = 0 {
        didSet {
            let radius:CGFloat = 10
            let startAngle = -Double.pi*0.5
            let endAngle = Double.pi * 2 * progress  + startAngle
            let path = UIBezierPath(arcCenter: CGPoint(x: 22.5, y: 22.5), radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
            self.shapeLayer.path = path.cgPath
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setImage(UIImage(named: "Music_SusPause"), for: .normal)
        setImage(UIImage(named: "Music_SusPlay"), for: .selected)
        
        let radius:CGFloat = 10
        let startAngle = -Double.pi*0.5
        let endAngle = -Double.pi*0.5
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.hex("61d8bb").cgColor
        layer.addSublayer(shapeLayer)
        
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
