//
//  TabBarController.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/8.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChildViewController(MusicMainViewController(), title: "音乐")
        addChildViewController(WeatherMainViewController(), title: "天气")
        
    }
    
    func addChildViewController(_ childController: BaseViewController, title: String) {
        
        childController.title = title
        let nav = NavigationViewController.init(rootViewController: childController)
        nav.navigationBar.prefersLargeTitles = true
        childController.navigationItem.largeTitleDisplayMode = .automatic
        addChildViewController(nav)
        
    }
    
}
