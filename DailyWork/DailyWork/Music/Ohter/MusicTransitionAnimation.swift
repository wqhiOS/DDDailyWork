//
//  MusicTransitionAnimation.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class MusicTransitionAnimation: NSObject {
    static let shared = MusicTransitionAnimation()
    var isPresented = false
}
extension MusicTransitionAnimation: UIViewControllerTransitioningDelegate {
    
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }

}

extension MusicTransitionAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if self.isPresented == true {
            //弹出动画=
            
            guard let presentedVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),let playVc = presentedVc as? MusicPlayViewController else {
                return
            }
            
            playVc.view.alpha = 1
            transitionContext.containerView.addSubview(playVc.view)
            
            playVc.showAnimation { (isComplete) in
                
            }
            transitionContext.completeTransition(true)
//            UIView.animate(withDuration: 0.5, animations: {
//                playVc.view.alpha = 1
//            }) { (_) in
//
//            }
        }else {
            //消失动画
            guard let presentedVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),let playVc = presentedVc as? MusicPlayViewController else {
                return
            }
            playVc.dismissAnimation()
            UIView.animate(withDuration: 0.5, animations: {
                playVc.view.alpha = 0
            }) { (_) in
                playVc.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
            
        }
        
    }
    
    
}
