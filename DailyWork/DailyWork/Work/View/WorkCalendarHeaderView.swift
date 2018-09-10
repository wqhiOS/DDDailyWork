//
//  WorkCalendarHeaderView.swift
//  DailyWork
//
//  Created by wuqh on 2018/9/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class WorkCalendarHeaderView: UICollectionReusableView {
    
    private lazy var label = UILabel(font: UIFont.pingFangSCMediumAndSize(16), textColorHex: "666666", textAlignment: .center, lines: 1, text: "2018年 9月")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor.white
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
//            make.height.equalTo(40)
        }
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment  = .center
//        stackView
//        stackView.spacing = CGFloat.leastNormalMagnitude
        for i in ["周日","周一","周二","周三","周四","周五","周六"] {
            let label = UILabel(font: UIFont.pingFangSCRegularAndSize(12), textColorHex: "666666", textAlignment: .center, lines: 1, text: i)
            stackView.addArrangedSubview(label)
        }
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
    }
}
