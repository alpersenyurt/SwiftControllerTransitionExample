//
//  ViewController.swift
//  ASTransitionExample
//
//  Created by Alper Senyurt on 12/7/14.
//  Copyright (c) 2014 Alper Senyurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailViewController: ASResultViewController = segue.destinationViewController as ASResultViewController
        detailViewController.transitioningDelegate = self;
        detailViewController.modalPresentationStyle = .Custom
    }


    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var animator = ASDropTransitionAnimator()
        animator.presenting = true
        return animator;
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var animator = ASDropTransitionAnimator()
        animator.presenting = false
        return animator;
    }
}


