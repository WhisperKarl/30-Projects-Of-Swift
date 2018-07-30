//
//  TransitionManager.swift
//  Tumblr
//
//  Created by Karl on 2017/3/29.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    fileprivate var presenting = false
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //拿到 containerView
        let container = transitionContext.containerView
        //创建一个装有 from 和 to 控制器的元组
        let screens:(from: UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        let menuView  = menuViewController.view
        let bottomView = bottomViewController.view
        
        if self.presenting {
           offStageMenuViewController(menuViewController)
        }
        container.addSubview(bottomView!)
        container.addSubview(menuView!)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                self.onStageMenuController(menuViewController) // onstage items: slide in
            }
            else {
                self.offStageMenuViewController(menuViewController) // offstage items: slide out
            }
            
        }, completion: { finished in
            transitionContext.completeTransition(true)
            UIApplication.shared.keyWindow?.addSubview(screens.to.view)
            
        })
        
    }
    
    func offStage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuViewController(_ menuViewController: MenuViewController){
        menuViewController.view.alpha = 0
        
        let topRowOffset :CGFloat = 300
        let middleRowOffset :CGFloat = 150
        let bottomRowOffset :CGFloat = 50
        
        menuViewController.textImage.transform = self.offStage(-topRowOffset)
        menuViewController.textLabel.transform = self.offStage(-topRowOffset)
        menuViewController.photoImage.transform = self.offStage(topRowOffset)
        menuViewController.photoLabel.transform = self.offStage(topRowOffset)

        
        menuViewController.quoteImage.transform = self.offStage(-middleRowOffset)
        menuViewController.quoteLabel.transform = self.offStage(-middleRowOffset)
        menuViewController.linkImage.transform = self.offStage(middleRowOffset)
        menuViewController.linkLabel.transform = self.offStage(middleRowOffset)
        
        menuViewController.chatImage.transform = self.offStage(-bottomRowOffset)
        menuViewController.chatLabel.transform = self.offStage(-bottomRowOffset)
        menuViewController.audioImage.transform = self.offStage(bottomRowOffset)
        menuViewController.audioLabel.transform = self.offStage(bottomRowOffset)
    }
    
    func onStageMenuController(_ menuViewController : MenuViewController) {
        menuViewController.view.alpha = 1
        
        menuViewController.textImage.transform = CGAffineTransform.identity
        menuViewController.textLabel.transform = CGAffineTransform.identity
        menuViewController.photoImage.transform = CGAffineTransform.identity
        menuViewController.photoLabel.transform = CGAffineTransform.identity
        
        menuViewController.quoteImage.transform = CGAffineTransform.identity
        menuViewController.quoteLabel.transform = CGAffineTransform.identity
        menuViewController.linkImage.transform = CGAffineTransform.identity
        menuViewController.linkLabel.transform = CGAffineTransform.identity
        
        menuViewController.chatImage.transform = CGAffineTransform.identity
        menuViewController.chatLabel.transform = CGAffineTransform.identity
        menuViewController.audioImage.transform = CGAffineTransform.identity
        menuViewController.audioLabel.transform = CGAffineTransform.identity
        
    }
    

}

extension TransitionManager: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}
