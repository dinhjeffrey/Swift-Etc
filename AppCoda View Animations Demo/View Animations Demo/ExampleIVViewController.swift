//
//  ExampleIVViewController.swift
//  View Animations Demo
//
//  Created by Joyce Echessa on 2/4/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ExampleIVViewController: UITableViewController {
    
    let tableItems = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5",
        "Item 6", "Item 7", "Item 8", "Item 9", "Item 10", "Item 11",
        "Item 12", "Item 13", "Item 14", "Item 15"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return tableItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableItems[indexPath.row]
        
        return cell
    }
    
}
