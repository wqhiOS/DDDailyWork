//
//  UIScrollView+Extension.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/9.
//  Copyright © 2018年 wuqh. All rights reserved.
//
import UIKit


// MARK: - 下拉刷新
extension UIScrollView {
    
    private var refreshFinished:(()->Void)? {
        get {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "refreshKey".hashValue)
            return objc_getAssociatedObject(self, key) as? () -> Void
        }
        set {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "refreshKey".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    func addRefreshControl(finished:@escaping ()->Void) {
        let rc = UIRefreshControl.init()
        rc.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refreshFinished = finished
        self.refreshControl = rc
    }
    
    @objc private func refresh() {
        refreshFinished?()
    }
}
