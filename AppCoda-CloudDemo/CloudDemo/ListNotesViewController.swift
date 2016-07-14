//
//  ViewController.swift
//  CloudDemo
//
//  Created by Gabriel Theodoropoulos on 9/4/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import CloudKit

class ListNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblNotes: UITableView!
    
    /*
     Let’s get started, but first things first. As always when working with tableviews, we need an array to be the datasource, so, of course, we’ll create one. However, it’s really important to set the proper data type of its contents, because that will make a huge difference to our upcoming work. The best choice is to let that array accept CKRecord objects, and let me tell you why:
     
     1. The records we’ll fetch from the iCloud are CKRecord objects, so we can append them straight away to that array.
     2. We can access all the properties of a CKRecord object directly, especially when we’ll need to display each note details to the tableview.
     3. Selecting (by tapping) and passing a CKRecord object to the EditNoteViewController class really makes things easy.
     4. Getting a CKRecord object back from the EditNoteViewController class allows to instantly display its details with no further processing.
    */
    var arrNotes: [CKRecord] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblNotes.delegate = self
        tblNotes.dataSource = self
        tblNotes.hidden = true
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
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0.0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

