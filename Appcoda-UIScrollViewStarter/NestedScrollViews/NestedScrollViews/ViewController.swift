//
//  ViewController.swift
//  NestedScrollViews
//
//  Created by Joyce Echessa on 6/8/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

// We’ll need to know when the foreground view is scrolled, so we can calculate the amount the background should scroll by and use this value to scroll it. We’ll use a UIScrollViewDelegate method for this.
class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var background: UIScrollView!
    @IBOutlet weak var foreground: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        foreground.delegate = self
    }
    // In the above code, we get the height of the foreground and calculate by how much the foreground has been scrolled. We then take this value and multiply it with the background’s height and use this in setting the background’s contentOffset which will result with the background moving a little bit faster than the foreground, each time the foreground is scrolled. Run the app and you’ll see the parallax effect created by this.
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let foregroundHeight = foreground.contentSize.height - CGRectGetHeight(foreground.bounds)
        let percentageScroll = foreground.contentOffset.y / foregroundHeight
        let backgroundHeight = background.contentSize.height - CGRectGetHeight(background.bounds)
        
        background.contentOffset = CGPoint(x: 0, y: backgroundHeight * percentageScroll)
    }

    


}

