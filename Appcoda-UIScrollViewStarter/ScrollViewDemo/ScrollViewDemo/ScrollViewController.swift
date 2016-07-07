//
//  ViewController.swift
//  ScrollViewController
//
//  Created by Joyce Echessa on 6/3/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // The above creates a scroll view and an image view. The image view is set as a subview of the scroll view. contentSize sets the size of the scrollable region. We set it equal to the size of the image view (2000 x 1500). We set the scroll view’s background color to black so that the image can have a black backdrop. We set the scroll view’s autoresizingMask to .FlexibleWidth and .FlexibleHeight so that it readjusts its size when the device is rotated. Run the app and you should be able to scroll through and see the different parts of the image.
        imageView = UIImageView(image: UIImage(named: "image.png"))
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
    }


}

