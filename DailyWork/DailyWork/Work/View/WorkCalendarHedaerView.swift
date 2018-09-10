//
//  WorkCalendarHedaerView.swift
//  DailyWork
//
//  Created by wuqh on 2018/9/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class WorkCalendarHedaerView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let label = UILabel()
        label.text = "2018年 9月"
        label.textColor = UIColor.red
        label.font = UIFont.pingFangSCMediumAndSize(20)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
}
