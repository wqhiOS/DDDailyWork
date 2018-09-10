//
//  WorkCalendarViewController.swift
//  DailyWork
//
//  Created by wuqh on 2018/9/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class WorkCalendarViewController: UIViewController {
    
    var isShow: Bool = false
    static var contentHeight = WorkCalendarContentViewController.contentHeight + 40
    
    let calendarPageVc = WorkCalendarPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private lazy var calendarView: UIView = {
        let calendarView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: WorkCalendarContentViewController.contentHeight+40))
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        titleView.backgroundColor = UIColor.hex("61d8bb")
        let titleLabel = UILabel(font: UIFont.pingFangSCMediumAndSize(15), textColorHex: "ffffff", textAlignment: .center, lines: 1, text: "...日历...")
        titleLabel.frame = CGRect(x: 60, y: 0, width: SCREEN_WIDTH-120, height: 40)
        titleView.addSubview(titleLabel)
        calendarView.addSubview(titleView)
        
        addChildViewController(calendarPageVc)
        calendarPageVc.view.frame = CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: WorkCalendarContentViewController.contentHeight)
        calendarView.addSubview(calendarPageVc.view)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(calendarTitleClick))
        calendarView.addGestureRecognizer(tap)
        calendarView.isUserInteractionEnabled = true
        return calendarView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(calendarView)
    }

    @objc private func calendarTitleClick() {
        isShow = !isShow
        UIView.animate(withDuration: 0.4) {
            self.view.frame.origin.y = self.isShow ? SCREEN_HEIGHT - 49 - self.calendarView.bounds.height : SCREEN_HEIGHT - 49 - 40
        }
    }

}
