//
//  WorkCalendarCell.swift
//  DailyWork
//
//  Created by wuqh on 2018/9/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class WorkCalendarCell: UICollectionViewCell {
    
    lazy var label = UILabel(font: UIFont.pingFangSCRegularAndSize(14), textColorHex: "61d8bb", textAlignment: .center, lines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor.white
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
