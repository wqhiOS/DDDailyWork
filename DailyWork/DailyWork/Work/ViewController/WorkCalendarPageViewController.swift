//
//  WorkCalendarViewController.swift
//  DailyWork
//
//  Created by wuqh on 2018/9/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class WorkCalendarPageViewController: UIPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        dataSource = self
        
        setViewControllers([WorkCalendarContentViewController()], direction: .forward, animated: true, completion: nil)
    }

}

extension WorkCalendarPageViewController {
    //获取当前日期
    private func getCurrentDate() {
        
    }
}

extension WorkCalendarPageViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 10
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return WorkCalendarContentViewController()
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return WorkCalendarContentViewController()
    }
    
}
