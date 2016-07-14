//
//  ViewController.swift
//  CloudDemo
//
//  Created by Gabriel Theodoropoulos on 9/4/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import CloudKit

class ListNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditNoteViewControllerDelegate {

    @IBOutlet weak var tblNotes: UITableView!
    
    /*
     Let’s get started, but first things first. As always when working with tableviews, we need an array to be the datasource, so, of course, we’ll create one. However, it’s really important to set the proper data type of its contents, because that will make a huge difference to our upcoming work. The best choice is to let that array accept CKRecord objects, and let me tell you why:
     
     1. The records we’ll fetch from the iCloud are CKRecord objects, so we can append them straight away to that array.
     2. We can access all the properties of a CKRecord object directly, especially when we’ll need to display each note details to the tableview.
     3. Selecting (by tapping) and passing a CKRecord object to the EditNoteViewController class really makes things easy.
     4. Getting a CKRecord object back from the EditNoteViewController class allows to instantly display its details with no further processing.
    */
    var arrNotes: [CKRecord] = []
    var selectedNoteIndex: Int!
    
    func fetchNotes() {
        let container = CKContainer.defaultContainer()
        let privateDatabase = container.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Notes", predicate: predicate)
        // As you see, a results array is returned in the completion handler above. In case that no error occurs, we first keep all the found records to the arrNotes array (the one we declared earlier), and then we make sure that the received data will be displayed to the tableview by simply reloading it and making it visible. Note that we do that in the main thread. By making the tableview visible, we “cover” the activity view indicator that is spinning by default.
        privateDatabase.performQuery(query, inZoneWithID: nil) { (results, error) in
            if error != nil {
                print(error)
            } else {
                print(results)
            }
            for result in results! {
                self.arrNotes.append(result)
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.tblNotes.reloadData()
                self.tblNotes.hidden = false
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblNotes.delegate = self
        tblNotes.dataSource = self
        tblNotes.hidden = true
        fetchNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UITableView method implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // All we do above is to dequeue each cell, and assign each object of the arrNotes array to a local variable. Then, we get the note title and set it as the text of the main cell’s label.
        let cell = tableView.dequeueReusableCellWithIdentifier("idCellNote", forIndexPath: indexPath) 
        
        let noteRecord: CKRecord = arrNotes[indexPath.row]
        
        cell.textLabel?.text = noteRecord.valueForKey("noteTitle") as? String
        // Regarding the last edited date, we need to convert it to a String object before we display it. For that cause, we’ll use a NSDateFormatter object, and we’ll set a custom format for its display:
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy, hh:mm"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(noteRecord.valueForKey("noteEditedDate") as! NSDate)
        //Before we use the image returned along with the rest data in each record, it’s important to say that during the fetching process all the assets are stored to the cache directory of the app. That means that all images are downloaded every time we fetch the note records, and they stay there temporarily until the app gets terminated. Now, every image existing in each record, is expressed as a CKAsset object. This object also contains the temporary image path, and we’ll use it so we load each image and set it to the cell’s image view. Here we go:
        let imageAsset: CKAsset = noteRecord.valueForKey("noteImage") as! CKAsset
        cell.imageView?.image = UIImage(contentsOfFile: imageAsset.fileURL.path!)
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedNoteIndex = indexPath.row
        performSegueWithIdentifier("idSegueEditNote", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "idSegueEditNote" {
            let editNoteViewController = segue.destinationViewController as! EditNoteViewController
            
            editNoteViewController.delegate = self
            
            if let index = selectedNoteIndex {
                editNoteViewController.editedNoteRecord = arrNotes[index]
            }
        }
    }
    
    // Finally, let’s implement the delegate method. As you’ll see, we first check if a new or an existing record was saved. In the first case, we just append it to the arrNotes array. In the second case, we replace the object in the index pointed by the selectedNoteIndex, and then we make that variable nil. At the end, we ensure that the tableview is visible we reload its data:
    func didSaveNote(noteRecord: CKRecord, wasEditingNote: Bool) {
        if !wasEditingNote {
            arrNotes.append(noteRecord)
        } else {
            arrNotes.insert(noteRecord, atIndex: selectedNoteIndex)
            arrNotes.removeAtIndex(selectedNoteIndex + 1)
            selectedNoteIndex = nil
        }
        
        if tblNotes.hidden {
            tblNotes.hidden = false
        }
        
        tblNotes.reloadData()
    }
    
    // In the following tableview delegate method we’ll implement, at first we get the record ID of the record matching to the tapped row. Then, as usual, we specify the container and the database, and finally we make a call to the deleteRecordWithID(…) of the CloudKit. If everything works without errors, we remove the respective object from the arrNotes array, and of course, we update the tableview. Simple things, so let’s see everything at once:
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let selectedRecordID = arrNotes[indexPath.row].recordID
            
            let container = CKContainer.defaultContainer()
            let privateDatabase = container.privateCloudDatabase
            
            privateDatabase.deleteRecordWithID(selectedRecordID) { (recordID, error) in
                if error != nil {
                    print(error)
                } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.arrNotes.removeAtIndex(indexPath.row)
                        self.tblNotes.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

