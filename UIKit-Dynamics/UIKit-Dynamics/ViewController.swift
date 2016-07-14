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
    
    lazy var collider: UICollisionBehavior = {
        let lazyCollider = UICollisionBehavior()
        // This line, makes the boundries of our reference view a boundary
        // for the added items to collide with
        lazyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazyCollider
    }()
    
    lazy var dynamicItemBehavior: UIDynamicItemBehavior = {
        let lazyBehavior = UIDynamicItemBehavior()
        // let's make our square elastic
        // 0 = no elasticity, 1.0 = max elasticity
        lazyBehavior.elasticity = 0.8
        
        // Other configs
        // lazyBehavior.allowsRotation
        // lazyBehavior.density
        // lazyBehavior.friction
        // lazyBehavior.resistance
        
        return lazyBehavior
    }()
    
    func animateSquare() {
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
        // add the dynamicItemBehavior to the animator
        animator.addBehavior(dynamicItemBehavior)
        
        collider.addItem(squareView)
        gravity.addItem(squareView)
        // and add the squareView to the dynamicItemBehavior
        dynamicItemBehavior.addItem(squareView)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

