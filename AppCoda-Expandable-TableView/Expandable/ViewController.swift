//
//  ViewController.swift
//  Expandable
//
//  Created by Gabriel Theodoropoulos on 28/10/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
    
    // The parameter that the above function accepts is the index path value (NSIndexPath) of the cell that is currently being processed by the tableview, and it returns a dictionary containing all the properties matching to that cell. The first task in its body is to find the index of the visible row that matches to the given index path, and that’s easy to do as all we need is the section and row of the cell. At the moment you don’t have the full picture as we haven’t dealt at all so far with the tableview delegate methods, so I must say in advance that the total number of rows per section will match to the number of visible cells in every section. That means that any indexPath.row value in the above implementation matches to the proper visible cell index in the visibleRowsPerSection.
    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = cellDescriptors[indexPath.section][indexOfVisibleRow] as! [String: AnyObject]
        return cellDescriptor
    }
    
    
    // This two-dimensional array will store the index of the visible cells for each section (one dimension for the sections, one for the rows).
    var visibleRowsPerSection = [[Int]]()
    // implementing visible cell function
    func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        
        for currentSectionCells in cellDescriptors {
            var visibleRows = [Int]()
            
            for row in 0...((currentSectionCells as! [[String: AnyObject]]).count - 1) {
                if currentSectionCells[row]["isVisible"] as! Bool == true {
                    visibleRows.append(row)
                }
            }
            
            visibleRowsPerSection.append(visibleRows)
        }
    }
    
    
    
    
    // This array will contain all the cell description dictionaries that will be loaded from the property list file.
    var cellDescriptors: NSMutableArray!
    // new custom function that’s responsible for loading the file contents into the array
    func loadCellDescriptors() {
        if let path = NSBundle.mainBundle().pathForResource("CellDescriptor", ofType: "plist") {
            cellDescriptors = NSMutableArray(contentsOfFile: path)
            getIndicesOfVisibleRows()
            tblExpandable.reloadData()
        }
    }
    
    
    // MARK: IBOutlet Properties
    
    @IBOutlet weak var tblExpandable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        loadCellDescriptors()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Custom Functions
    
    func configureTableView() {
        tblExpandable.delegate = self
        tblExpandable.dataSource = self
        tblExpandable.tableFooterView = UIView(frame: CGRectZero)
        
        tblExpandable.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        tblExpandable.registerNib(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
        tblExpandable.registerNib(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
        tblExpandable.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
        tblExpandable.registerNib(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
        tblExpandable.registerNib(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
    }
    
    
    // MARK: UITableView Delegate and Datasource Functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if cellDescriptors != nil {
            return cellDescriptors.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRowsPerSection[section].count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Personal"
            
        case 1:
            return "Preferences"
            
        default:
            return "Work Experience"
        }
    }
    
    
    // There’s something that I’d like to underline here: For first time we make use of the getCellDescriptorForIndexPath: function that was implemented earlier in this part. We need to get the proper cell descriptor, because right next it’s necessary to fetch the “cellIdentifier” property, and depending on its value to specify the row height. You can verify the height values for each type of cell in the respective xib files (or just take them as granted as shown here)
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        
        switch currentCellDescriptor["cellIdentifier"] as! String {
        case "idCellNormal":
            return 60.0
            
        case "idCellDatePicker":
            return 270.0
            
        default:
            return 44.0
        }
    }
    
    /*
     we begin by getting the proper cell descriptor based on the current index path value. By using the “cellIdentifier” property the correct cell is being dequeued, so we can dive deep down to the special treatment of each cell
     For normal cells, we just set the primaryTitle and secondaryTitle text values to the textLabel and detailTextLabel labels respectively. In our demo app, the cells with the idCellNormal identifier are actually the top-level cells that get expanded and collapsed.
     For cells containing a textfield, we just set the placeholder value that is specified by the primaryTitle property of the cell descriptor.
     Regarding the cell that contains a switch control, there are two things we do here: We firstly specify the displayed text before the switch (this is constant in our case and can be changed in the CellDescriptor.plist file), and then we set the proper state of the switch, depending on whether it’s been set as “on” or not in the descriptor. Note that later we’ll be able to change that value.
     
     There are also the cells having the “idCellValuePicker” identifier. Those cells are meant to provide a list of options, and when an option is selected the parent cell will automatically collapse. The cell’s text label is specified in the case shown above.
     
     Lastly, there’s the case of the cell containing a slider. Here we just get the current value from the currentCellDescriptor dictionary, we convert it into a float number, and we assign it to the slider control so it shows the proper value all the time (when it’s visible). Later on we’ll change that value and we’ll update the respective cell descriptor.
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(currentCellDescriptor["cellIdentifier"] as! String, forIndexPath: indexPath) as! CustomCell
        
        if currentCellDescriptor["cellIdentifier"] as! String == "idCellNormal" {
            if let primaryTitle = currentCellDescriptor["primaryTitle"] {
                cell.textLabel?.text = primaryTitle as? String
            }
            
            if let secondaryTitle = currentCellDescriptor["secondaryTitle"] {
                cell.detailTextLabel?.text = secondaryTitle as? String
            }
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellTextfield" {
            cell.textField.placeholder = currentCellDescriptor["primaryTitle"] as? String
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSwitch" {
            cell.lblSwitchLabel.text = currentCellDescriptor["primaryTitle"] as? String
            
            let value = currentCellDescriptor["value"] as? String
            cell.swMaritalStatus.on = (value == "true") ? true : false
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellValuePicker" {
            cell.textLabel?.text = currentCellDescriptor["primaryTitle"] as? String
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSlider" {
            let value = currentCellDescriptor["value"] as! String
            cell.slExperienceLevel.value = (value as NSString).floatValue
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}











































