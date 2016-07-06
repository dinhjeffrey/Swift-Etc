/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ZoomedPhotoViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  var photoName: String!
  
  override func viewDidLoad() {
    imageView.image = UIImage(named: photoName)
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // update the minimum zoom scale each time the controller updates it’s subviews
    updateMinZoomScaleForSize(view.bounds.size)
  }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
  
  // You set the initial zoom scale to be the minimum, so that the image starts fully zoomed out.
  private func updateMinZoomScaleForSize(size: CGSize) {
    let widthScale = size.width / imageView.bounds.width
    let heightScale = size.width / imageView.bounds.height
    let minScale = min(widthScale, heightScale)
    
    scrollView.minimumZoomScale = minScale
    
    scrollView.zoomScale = minScale
  }
  
  // The method helps to get around a slight annoyance with UIScrollView: if the scroll view content size is smaller than its bounds, then it sits at the top-left rather than in the center. Since you’ll be allowing the user to zoom all the way out, it would be nice if the image sat in the center of the view. This function accomplishes that by adjusting the layout constraints.
  // You center the image vertically by subtracting the height of imageView from the view‘s height and dividing it in half. This value is used as padding for the top and bottom imageView constraints.
  // Likewise, you calculate an offset for the leading and trailing constraints of imageView.
  private func updateConstraintsForSize(size: CGSize) {
    let yOffset = max(0, (size.height - imageView.frame.height) / 2)
    imageViewTopConstraint.constant = yOffset
    imageViewBottomConstraint.constant = yOffset
    
    let xOffset = max(0, (size.width - imageView.frame.width) / 2)
    imageViewLeadingConstraint.constant = xOffset
    imageViewTrailingConstraint.constant = xOffset
    
    view.layoutIfNeeded()
  }
    
    
}

extension ZoomedPhotoViewController: UIScrollViewDelegate {
    // This is the heart and soul of the scroll view’s zooming mechanism. You’re telling it which view should be made bigger and smaller when the scroll view is pinched. So, you tell it that it’s your imageView.
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
  // Here, the scroll view re-centers the view each time the user scrolls – if you don’t, the scroll view won’t appear to zoom naturally; instead, it will sort of stick to the top-left.
  func scrollViewDidZoom(scrollView: UIScrollView) {
    updateConstraintsForSize(view.bounds.size)
  }
}


