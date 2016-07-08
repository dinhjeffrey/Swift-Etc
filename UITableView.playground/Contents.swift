//: Playground - noun: a place where people can play

import UIKit

// UITableView

// UITableView Protocols
// Connections to code are made using the UITableView's dataSource and delegate
// The delegate is used to control HOW the table is displayed (it's look and feel)
// The dataSource provides THE DATA that is displayed inside the cells

// When do we need to implement the dataSource?
// Wheenever the data in the table is dynamic (not static)
// There are 3 important methods in the dataSource protocol
// 1. how many sections in the table?
// 2. how many rows in each section?
// 3. give me a view to use to draw each cell at a given row in a given section

// implementing #3
func tableView(tv: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let data = myInternalDataStructure[indexPath.section][indexPath.row]
    // dequeue resuses UITableViewCell that goes offscreen. It doesn't create new ones, just reuses the ones onescreen
    let dequeued = tv.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
    
    dequeued.textLabel?.text = data.importantInfo
    dequeued.detailTextLabel?.text = data.lessImportantInfo
    return cell
}
// implementing customCell
func tableView(tv: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let data = myInternalDataStructure[indexPath.section][indexPath.row]
    // dequeue resuses UITableViewCell that goes offscreen. It doesn't create new ones, just reuses the ones onescreen
    let dequeued = tv.dequeueReusableCellWithIdentifier("MyCustomCell", forIndexPath: indexPath)
    
    if let cell = dequeued as? MyTableViewCell {
        cell.publicAPIofMyTableViewCell = data.TheDataTheCellNeedsToDisplayItsCustomLabelsEtc
    }
    return cell
}

// UITableViewDataSource
// How does a dynamic table know how many rows there are?
// and how many sections too?
// Via these UITableViewDataSource protocol methods
func numberOfSectionsInTableView(sender: UITableView) -> Int
func tableView(sender: UITableView, numberOfRowsInSection: Int) -> Int

// What about a static table?
// do not implement these dataSource methods for static table. 
// The UITableViewController takes care of it for you
// you can edit data directly in storyboard


// Summary
// 1. set the table view's dataSource to your Controller (automatic with UITableViewController)
// 2. implement numberOfSectionsInTableView and numberOfRowsInSection
// 3. implement cellForRowAtIndexPath to return loaded-up UITableViewCells


// Section titles are also consider part of the table's 'data'
func tableView(UITableView, titleFor{Header,Footer}InSection: Int) -> String


// What if your model changes?
func reloadData()
// causes the UITableView to call numberOfSectionsInTableView and numberOfRowsInSection all over again and then cellForRowAtIndexPath on each visible row
// relatively heavy weight
// but if only part of your model changes, there are lighter-weight reloaders, for example...
func reloadRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation: UITableViewRowAnimation)


// Controlling the height of rows
// row height can be fixed(UITableView's var rowHeight: CGFloat)
// or it can be determined using autolayout (rowHeight = UITableViewAutomaticDimension)
// If you do automatic, help the table view out by setting estimatedRowHeight to something
// The UITableView's delegate can also control row heights...
func tableView(UITableView, {estimated}heightForRowAtIndexPath: NSIndexPath) -> CGFloat
// Beware: the non-estimated version of this could get called A LOT if you have a big table











































































