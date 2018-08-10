//
//  WeatherMainViewController.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/8.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class WeatherMainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let btn = MusicProgressButton()
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
