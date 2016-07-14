//
//  EditNoteViewController.swift
//  CloudDemo
//
//  Created by Gabriel Theodoropoulos on 9/4/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import QuartzCore
import CloudKit


class EditNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtNoteTitle: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var btnSelectPhoto: UIButton!
    
    @IBOutlet weak var btnRemoveImage: UIButton!
    
    @IBOutlet weak var viewWait: UIView!
    
    var imageURL: NSURL!
    let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    let tempImageName = "temp_image.jpg"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.hidden = true
        btnRemoveImage.hidden = true
        viewWait.hidden = true
        
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(EditNoteViewController.handleSwipeDownGestureRecognizer(_:)))
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.layer.cornerRadius = 10.0
        btnSelectPhoto.layer.cornerRadius = 5.0
        btnRemoveImage.layer.cornerRadius = btnRemoveImage.frame.size.width/2
        
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: IBAction method implementation
    
    @IBAction func pickPhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    // We must make the remove image button capable of unsetting the image view’s image
    @IBAction func unsetImage(sender: AnyObject) {
        imageView.image = nil
        
        imageView.hidden = true
        btnRemoveImage.hidden = true
        btnSelectPhoto.hidden = false
        
        imageURL = nil
    }
    
    
    @IBAction func saveNote(sender: AnyObject) {
    
    }
    
    // As I have already said, we need to store the picked image temporarily, and that means that at some point we have to delete it from the documents directory (it won’t be deleted on its own). The best place to do that, is in the dismiss(_:) IBAction method, which we’ll use to pop the current view controller. All we have to do there right before the popping occurs, is to check if the imageURL property is nil or not, and in case it has a valid value, to delete the file pointed by it.
    @IBAction func dismiss(sender: AnyObject) {
        if let url = imageURL {
            let fileManager = NSFileManager()
            if fileManager.fileExistsAtPath(url.absoluteString) {
                do {
                    try fileManager.removeItemAtURL(url)
                } catch {
                    print(error)
                }
            }
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: Custom method implementation
    
    func handleSwipeDownGestureRecognizer(swipeGestureRecognizer: UISwipeGestureRecognizer) {
        txtNoteTitle.resignFirstResponder()
        textView.resignFirstResponder()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        // The saveImageLocally() that comes next, is obviously a custom method that we’ll implement in a while. If we wouldn’t deal with the CloudKit, storing the image to the documents directory would be totally pointless. However, and according to what you’ll see to the next part, we’ll need to create a file URL (a special NSURL object) that points to that file and provide it to the CloudKit, so it can find the image and upload it to the iCloud.
        saveImageLocally()
        
        imageView.hidden = false
        btnRemoveImage.hidden = false
        btnSelectPhoto.hidden = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    // Initially, we convert the image to a NSData object simply by using the UIImageJPEGRepresentation(…) method. Then, we compose the path to the documents directory, and once that’s ready, we convert it to a file URL object. Of course, we store that to the imageURL property we declared previously. At the end, we write the data object to the specified path, and we’re good to go.
    func saveImageLocally() {
        let imageData: NSData = UIImageJPEGRepresentation(imageView.image!, 0.8)!
        let path = documentsDirectoryPath.stringByAppendingPathComponent(tempImageName)
        imageURL = NSURL(fileURLWithPath: path)
        imageData.writeToURL(imageURL, atomically: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
