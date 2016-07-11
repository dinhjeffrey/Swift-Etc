//
//  MenuTableViewController.swift
//  CoreDataPreloadDemo
//
//  Created by Simon Ng on 13/5/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class MenuTableViewController: UITableViewController {

    private var menuItems:[MenuItem] = []
    var fetchResultController:NSFetchedResultsController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load menu items from database
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {

            let fetchRequest = NSFetchRequest(entityName: "MenuItem")
            do {
                menuItems = try managedObjectContext.executeFetchRequest(fetchRequest) as! [MenuItem]
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }

        // Make the cell self size
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MenuTableViewCell

        // Configure the cell...
        cell.nameLabel.text = menuItems[indexPath.row].name
        cell.detailLabel.text = menuItems[indexPath.row].detail
        cell.priceLabel.text = "$\(menuItems[indexPath.row].price as! Double)"

        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
