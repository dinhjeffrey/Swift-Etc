//: Playground - noun: a place where people can play

import UIKit
import Foundation

// Adding subviews to a UIScrollView 
var scrollView: UIScrollView
var aerial: UIView
scrollView.contentSize = CGSize(width: 3000, height: 2000) // important to set contentSize!
aerial.frame = CGRect(x: 150, y: 200, width: 2500, height: 1600)
scrollView.addSubview(aerial)

// Where in the content is the scroll view currently positioned?
let upperLeftOfVisible: CGPoint = scrollView.contentOffset
// gives contentOffset.x
// gives contentOffset.y

// What area in a subview is currently visible?
let visibleRect: CGRect = aerial.convertRect(scrollView.bounds, toView: scrollView)
// Why the convertRect? Because the scrollView's bounds are in the scrollView's coordinate system. And there might be zooming going on inside the scrollView too


// How do you create a UIScrollView?
// Storyboard. Or select a UIView -> "Embed in ScrollView"

// Through code
let image = UIImage(named: "bigimage.jpg")
let iv = UIImageView(image: image)
scrollView.addSubview(iv)
// all of the subviews' frames will be in the UIScrollView's content area's coordinate system (that is, (0,0) in the upper left & width and height of contentSize.width & height)
// don't forget to add contentSize

// Scrolling programatically
func scrollRectToVisible(CGRect, animated: Bool)

// Zooming
// All UIView's have a property(transform) which is an affine transform (translate, transform, rotate)
// Will not work without minimum/maximum
scrollView.minimumZoomScale = 0.5
scrollView.maximumZoomScale = 2.0

// Will not work without delegate method to specific view to zoom
func viewForZoomingInScrollView(sender: UIScrollView) -> UIView

// Zooming programatically
var zoomScale: CGFloat
func setZoomScale(CGFloat, animated: Bool)
func zoomToRect(CGRect, animated: Bool)

