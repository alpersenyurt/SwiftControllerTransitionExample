//
//  ASDropBehavior.swift
//  ASTransitionExample
//
//  Created by Alper Senyurt on 12/7/14.
//  Copyright (c) 2014 Alper Senyurt. All rights reserved.
//

import UIKit

class ASDropBehavior: UIDynamicBehavior {
    
    private let kAngleInDegrees:CGFloat = 100.0
    private let kAngularVelocity:CGFloat = -2.9
    private let kMagnitude:CGFloat = 4.0
    private lazy var animationOptions = UIDynamicItemBehavior()
    private lazy var gravityBehavior: UIGravityBehavior = {  [unowned self] in
        var temporarygravityBehavior =  UIGravityBehavior()
        temporarygravityBehavior.magnitude = self.kMagnitude
        temporarygravityBehavior.angle = (self.kAngleInDegrees * CGFloat(M_PI)) / 180
        return temporarygravityBehavior
        }()
    
    
    
    init(item:UIDynamicItem) {
        super.init()
        
        self.gravityBehavior.addItem(item)
        self.animationOptions.addItem(item)
        self.animationOptions.addAngularVelocity(kAngularVelocity, forItem: item)
        
        self.addChildBehavior(self.gravityBehavior)
        self.addChildBehavior(self.animationOptions)
        
    }
    
    //pragma mark - Public
    func removeItem(item:UIDynamicItem) ->Void {
        
        self.gravityBehavior.removeItem(item)
        self.animationOptions.removeItem(item)
        
    }
}
