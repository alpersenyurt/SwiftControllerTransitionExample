//
//  ASDropTransitionAnimator.swift
//  ASTransitionExample
//
//  Created by Alper Senyurt on 12/7/14.
//  Copyright (c) 2014 Alper Senyurt. All rights reserved.
//

import UIKit
import Foundation;

class ASDropTransitionAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    private let kAnimatedTransitionDuration:NSTimeInterval = 0.5
    let yAxisPositionCorrection:CGFloat = 1.0
    var presenting:Bool = false
    let referenceView:UIView = UIApplication.sharedApplication().windows.first as UIView
    private lazy var animator: UIDynamicAnimator = {  [unowned self] in
        return UIDynamicAnimator(referenceView:self.referenceView)
        }()
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if self.presenting {
            self.addingAnimationTransition(transitionContext)
        } else {
            
            self.dismissalPresentation(transitionContext)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return kAnimatedTransitionDuration
    }
    
    func addingAnimationTransition(transitionContext:UIViewControllerContextTransitioning){
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        fromVC!.view.userInteractionEnabled = false;
        
        transitionContext.containerView().addSubview(toVC!.view)
        
        let startFrame:CGRect = self.startPresentingFrameFromViewController(fromVC!, toVC: toVC!)
        let endFrame:CGRect = self.endPresentingFrameFromViewController(fromVC!, toVC: toVC!)
        
        toVC!.view.frame = startFrame;
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { toVC!.view.frame = endFrame }, completion: { finished in transitionContext.completeTransition(true) })
        
        
    }
    
    func startPresentingFrameFromViewController (fromVC:UIViewController,toVC:UIViewController)->CGRect{
        
        var rect = toVC.view.subviews.first!.frame
        rect.origin.x = fromVC.view.center.x - (toVC.view.subviews.first!.frame.size.width/2)
        rect.origin.y = 0
        return rect
        
    }
    func endPresentingFrameFromViewController (fromVC:UIViewController,toVC:UIViewController)->CGRect{
        
        var rect = toVC.view.subviews.first!.frame
        rect.origin.x = fromVC.view.center.x - (toVC.view.subviews.first!.frame.size.width/2)
        rect.origin.y = fromVC.view.center.y - (toVC.view.subviews.first!.frame.size.height/2) * self.yAxisPositionCorrection
        return rect
        
    }
    
    func dismissalPresentation(transitionContext:UIViewControllerContextTransitioning){
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        toVC!.view.userInteractionEnabled = true;
        let dropBehavior = ASDropBehavior(item: fromVC!.view)
        self.animator.addBehavior(dropBehavior)
        let delayInSeconds = self.transitionDuration(transitionContext)
        let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, (Int64)(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            transitionContext.completeTransition(true)
            dropBehavior.removeItem(fromVC!.view)
        }
        
    }
    
}
