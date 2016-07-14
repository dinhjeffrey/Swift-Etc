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
        if txtNoteTitle.text == "" || textView.text == "" {
            return
        }
        // In the EditNoteViewController scene in the Interface Builder, you can find a UIView object with an activity indicator as its subview. That view has been already connected to an IBOutlet property, and it’s named viewWait (for obvious reasons). Right now, this view (along with the indicator) is hidden, so we’ll make it visible, we’ll bring it in front, and that way we’ll prohibit any interaction with the note. But that’s the half way, as it can’t “cover” the navigation bar. The navigation bar is always at the top of any subview, so, further than simply showing the viewWait view, at the same time we’ll hide the bar. Then, when everything is over, we’ll go in the completion handler that exists in the above method, and we’ll bring everything back to normal.
        
        viewWait.hidden = false
        view.bringSubviewToFront(viewWait)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // A nice way to ensure that every new record identifier we generate is going to be unique, is to use the current timestamp, which by default is unique. This timestamp is given to us using the timeIntervalSinceReferenceDate() method of the NSDate class, and it’s in the form of abc.def (where abc and def are real digits and more than three of course). Keeping the dot (.) in the identifier is not important, as only the integer part of the number is good for our cause. So what we’ll do is simple:
        
        // 1. We’ll get the current timestamp as a String value.
        // 2. We’ll split it to the integer and decimal parts.
       // 3.  We’ll use the integer part as the identifier of the new record.
        
        let timestampAsString = String(format: "%f", NSDate.timeIntervalSinceReferenceDate())
        let timestampParts = timestampAsString.componentsSeparatedByString(".")
        print(timestampParts)
        // As you can see, we created a new CKRecordID object named noteID. This is the key of the new record, and we’ll use it right next. In the following part, we create a new CKRecord object, and we set to it all the data we want to be saved, except for the image. We’ll see that in a while.
        let noteID = CKRecordID(recordName: timestampParts[0])
        
        let noteRecord = CKRecord(recordType: "Notes", recordID: noteID)
        
        noteRecord.setObject(txtNoteTitle.text, forKey: "noteTitle")
        noteRecord.setObject(textView.text, forKey: "noteText")
        noteRecord.setObject(NSDate(), forKey: "noteEditedDate")
        
        // Let’s handle now the image saving. As I have already mentioned, in case the user has picked an actual image we can proceed as planned. However, if no image has been picked, we’ll provide the default one existing in the app bundle. Note in the next snippet that first we create a CKAsset object (required for assets like images), and then we provide it to the noteRecord object.
        if let url = imageURL {
            let imageAsset = CKAsset(fileURL: url)
            noteRecord.setObject(imageAsset, forKey: "noteImage")
        } else {
            let fileURL = NSBundle.mainBundle().URLForResource("no_image", withExtension: "png")
            let imageAsset = CKAsset(fileURL: fileURL!)
            noteRecord.setObject(imageAsset, forKey: "noteImage")
        }
        // In the next step, we must specify the container that is used by the app (in this case is the default container), and then the desired database. According to what I said to the introduction, there are two kinds of databases: A public and a private. In this demo, we’ll use the private one. Here’s how we can achieve what I just said:
        let container = CKContainer.defaultContainer()
        let privateDatabase = container.privateCloudDatabase
        
        privateDatabase.saveRecord(noteRecord) { (record, error) in
            if error != nil {
                print(error)
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.viewWait.hidden = true
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
        // That’s it. By doing all the above actions, the app can now store data to the iCloud using the CloudKit. Note that the first time a record is saved, a record type is also created automatically (let’s say, the table in the database). It’s important to remember that if you need to change the record data and to add or remove “fields”, you’ll have to delete first the record type in the CloudKit Dashboard platform. We’ll see a few things about the Dashboard in the following part.
    
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
