//
//  ViewController.swift
//  UIKit-Dynamics
//
//  Created by jeffrey dinh on 7/13/16.
//  Copyright © 2016 jeffrey dinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    var squareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSquare()
        animateSquare()
    }
    
    func drawSquare() {
        let squareSize = CGSize(width: 30.0, height: 30.0)
        let centerPoint = CGPoint(x: self.animationView.bounds.midX - (squareSize.width/2), y: self.animationView.bounds.midY - (squareSize.height/2))
        let frame = CGRect(origin: centerPoint, size: squareSize)
        squareView = UIView(frame: frame)
        squareView.backgroundColor = UIColor.orangeColor()
        
        animationView.addSubview(squareView)
    }
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.animationView)
    }()
    
    lazy var gravity: UIGravityBehavior = {
        let lazyGravity = UIGravityBehavior()
        return lazyGravity
    }()

    func animateSquare() {
        // 1. Add behaviors to the animator
        animator.addBehavior(gravity)
        
        // 2. Add items to the behavior
        gravity.addItem(squareView)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

