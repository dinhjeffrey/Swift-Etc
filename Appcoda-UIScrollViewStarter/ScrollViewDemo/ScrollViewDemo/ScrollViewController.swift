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
        // This is because the scroll view’s bound origin is set to (0,0) which is at the top left corner. If you want to change the position of the content shown when the app launches, then you have to change the scroll views’s bound origin. Since setting this position is so common when working with scroll views, UIScrollView has a contentOffset property that you can change which will have the same effect as changing the bounds origin.
        scrollView.contentOffset = CGPoint(x: 1000, y: 450)
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        // You should also specify the amount the user can zoom in and out. You do this by setting values of the scroll view’s minimumZoomScale and maximumZoomScale properties. Both of these are set to 1.0 by default.
        scrollView.delegate = self
        
//        scrollView.minimumZoomScale = 0.1
//        scrollView.maximumZoomScale = 4.0
//        scrollView.zoomScale = 1.0
        // In the above, we set the minimumZoomScale to 0.1 which results in a pretty small image that leaves a lot of blank space on the screen. In landscape mode, the empty space next to the image is even larger. We want to make the image ‘Aspect Fit’ the scroll view so that it takes up as much space on the scroll view as it can while still showing the full image.
        setZoomScale()
    }
    
    


}

// To support zooming, you must set a delegate for your scroll view. The delegate object must conform to the UIScrollViewDelegate protocol. That delegate class must implement the viewForZoomingInScrollView() method and return the view to zoom.
extension ScrollViewController: UIScrollViewDelegate {
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }
}

