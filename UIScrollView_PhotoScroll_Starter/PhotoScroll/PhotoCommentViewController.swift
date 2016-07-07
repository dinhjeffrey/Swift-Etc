//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by jeffrey dinh on 7/6/16.
//  Copyright © 2016 raywenderlich. All rights reserved.
//

import UIKit



class PhotoCommentViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTextField: UITextField!
  // dismiss the keyboard
  @IBAction func hideKeyboard(sender: UITapGestureRecognizer) {
    nameTextField.endEditing(true)
  }
  internal var photoName: String!
  internal var photoIndex: Int!
  @IBAction func openZoomingController(sender: UITapGestureRecognizer) {
    self.performSegueWithIdentifier("zooming", sender: nil)
  }
  
  override internal func prepareForSegue(segue: UIStoryboardSegue,
                                       sender: AnyObject?) {
    if let id = segue.identifier,
      zoomedPhotoViewController = segue.destinationViewController as? ZoomedPhotoViewController {
      if id == "zooming" {
        zoomedPhotoViewController.photoName = photoName
      }
    }
  }

  
 var fixKeyboard = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
      if let photoName = photoName {
        self.imageView.image = UIImage(named: photoName)
      }
      // View controllers can make adjustments to their contents when the keyboard appears by listening for NSNotifications issued by iOS. The notifications contain a dictionary of geometry and animation parameters that can be used to smoothly animate the contents out of the way of the keyboard. You’ll first update your code to listen for those notifications.
      NSNotificationCenter.defaultCenter().addObserver(
        self,
        selector: #selector(PhotoCommentViewController.keyboardWillShow(_:)),
        name: UIKeyboardWillShowNotification,
        object: nil
      )
      NSNotificationCenter.defaultCenter().addObserver(
        self,
        selector: #selector(PhotoCommentViewController.keyboardWillHide(_:)),
        name: UIKeyboardWillHideNotification,
        object: nil
  )
}
  // stop listening for notifications when the object’s life ends
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  // adjustInsetForKeyboardShow(_:,notification:) takes the keyboard’s height as delivered in the notification, adds a padding value of 20 to either be subtracted from or added to the scroll views’s contentInset. This way, the UIScrollView will scroll up or down to let the UITextField always be visible on the screen.
  func adjustInsetForKeyboard(show: Bool, notification: NSNotification) {
    guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
    let keyboardFrame = value.CGRectValue()
    var adjustmentHeight: CGFloat = 0
    if !fixKeyboard {
        adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 20) * (show ? 1 : -1)
        fixKeyboard = true
    }
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  // When the notification is fired, either keyboardWillShow(_:) or keyboardWillHide(_:) will be called. These methods will then call adjustInsetForKeyboardShow(_:,notification:), indicating which direction to move the scroll view.
  func keyboardWillShow(notification: NSNotification) {
    adjustInsetForKeyboard(true, notification: notification)
  }
  func keyboardWillHide(notification: NSNotification) {
    adjustInsetForKeyboard(true, notification: notification)
  }

}
