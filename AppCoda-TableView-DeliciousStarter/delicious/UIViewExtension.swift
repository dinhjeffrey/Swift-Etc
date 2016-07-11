//
//  UIViewExtension.swift
//  Delicious
//
//  Created by jeffrey dinh on 7/10/16.
//  Copyright © 2016 Demo. All rights reserved.
//
import UIKit
import Foundation

extension UIView {
    func slideInFromBottom(duration: NSTimeInterval = 0.1, completionDelegate: AnyObject? = nil) {
        let slideInFromBottomTransition = CATransition()
        
        if let delegate: AnyObject = completionDelegate {
            slideInFromBottomTransition.delegate = delegate
        }
        
        slideInFromBottomTransition.type = kCATransitionPush
        slideInFromBottomTransition.subtype = kCATransitionFromTop
        slideInFromBottomTransition.duration = duration
        slideInFromBottomTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.layer.addAnimation(slideInFromBottomTransition, forKey: "slideInFromBottomTransition")
    }
}

















































