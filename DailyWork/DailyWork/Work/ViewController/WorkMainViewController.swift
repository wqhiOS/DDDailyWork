//
//  WorkMainViewController.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/15.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class WorkMainViewController: BaseViewController {
    
    let calendarViewController = WorkCalendarViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildViewController(calendarViewController)
        calendarViewController.view.frame = CGRect(x: 0, y: SCREEN_HEIGHT-49-WorkCalendarViewController.contentHeight, width: SCREEN_WIDTH, height: WorkCalendarViewController.contentHeight)
        view.addSubview(calendarViewController.view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}

