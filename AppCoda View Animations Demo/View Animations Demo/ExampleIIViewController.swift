//
//  ExampleIIViewController.swift
//  View Animations Demo
//
//  Created by Joyce Echessa on 1/30/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ExampleIIViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        let firstImageView = UIImageView(image: UIImage(named: "bg01.png"))
        firstImageView.frame = view.frame
        view.addSubview(firstImageView)
        
        imageFadeIn(firstImageView)
    }
    // Here we create an image view and add it to the main view. We then call imageFadeIn() which creates a second view with a different image. We add this view above the first image view and set its alpha to 0. In the animation block, we animate its alpha value, making it visible. We then use a completion closure to set the image view’s image to the second image and we remove the second image view from the view hierarchy since it is no longer needed. I’ve added a long delay so that the animation doesn’t happen right at the moment we select Example II from the table view.
    func imageFadeIn(imageView: UIImageView) {
        let secondImageView = UIImageView(image: UIImage(named: "bg02.png"))
        secondImageView.frame = view.frame
        secondImageView.alpha = 0.0
        
        view.insertSubview(secondImageView, aboveSubview: imageView)
        
        UIView.animateWithDuration(2.0, delay: 2.0, options: .CurveEaseOut, animations: { 
            secondImageView.alpha = 1.0
            }) { _ in
                imageView.image = secondImageView.image
                secondImageView.removeFromSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
