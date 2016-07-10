//
//  ViewController.swift
//  Expandable
//
//  Created by Gabriel Theodoropoulos on 28/10/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//
/* Summary 
 In the previous parts of this tutorial I presented you an approach for making expandable tableviews where the main characteristic of it is the description of all cells using specific properties in a property list file (plist). I showed how you can handle this cell description list in code when displaying, expanding and selecting cells; additionally I gave you a way to directly update it with the data entered by the user. Even though a form like the fake one in our demo app could exist in a real app, there are still things needed to be done before it stands as a complete component (for example, save the cell description list back to file). However, that’s out of our goal here; what we initially wanted was to implement an expandable tableview with cells that appear or hide on demand, and that’s what we eventually did.
 */

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {
    
    func dateWasSelected(selectedDateString: String) {
        let dateCellSection = 0
        let dateCellRow = 3
        
        cellDescriptors[dateCellSection][dateCellRow].setValue(selectedDateString, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    func maritalStatusSwitchChangedState(isOn: Bool) {
        let martialSwitchCellSection = 0
        let martialSwitchCellRow = 6
        
        let valueToStore = (isOn) ? "true" : "false"
        let valueToDisplay = (isOn) ? "Married" : "Single"
        
        cellDescriptors[martialSwitchCellSection][martialSwitchCellRow].setValue(valueToStore, forKey: "value")
        cellDescriptors[martialSwitchCellSection][martialSwitchCellRow - 1].setValue(valueToDisplay, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    func textfieldTextWasChanged(newText: String, parentCell: CustomCell) {
        let parentCellIndexPath = tblExpandable.indexPathForCell(parentCell)
        
        let currentFullname = cellDescriptors[0][0]["primaryTitle"] as! String
        let fullnameParts = currentFullname.componentsSeparatedByString(" ")
        
        var newFullname = ""
        
        if parentCellIndexPath?.row == 1 {
            if fullnameParts.count == 2 {
                newFullname = "\(newText) \(fullnameParts[1])"
            } else {
                newFullname = newText
            }
        } else {
            newFullname = "\(fullnameParts[0]) \(newText)"
        }
        cellDescriptors[0][0].setValue(newFullname, forKey: "primaryTitle")
        tblExpandable.reloadData()
    }
    func sliderDidChangeValue(newSliderValue: String) {
        cellDescriptors[2][0].setValue(newSliderValue, forKey: "primaryTitle")
        cellDescriptors[2][1].setValue(newSliderValue, forKey: "value")
        
        tblExpandable.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.None)
    }
    
    
    
    
    
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
        cell.delegate = self
        return cell
    }
    
    // Once the above flag gets its value and properly indicates whether the cell should expand or not, it’s our duty to save that value to the cell descriptors collection, or in other words, to update the cellDescriptors array. We want to update the “isExpanded” property of the selected cell, so it will behave correctly in subsequent tapping (to collapse if it’s expanded, and to expand if it’s collapsed).
    // There’s one really important detail we should not forget at this point: If you recall, there’s one property that specifies whether a cell should be displayed or not, named “isVisible” and exists in the description of each cell. This property must be changed in accordance to the above flag, so the additional invisible rows to become visible when the cell is expanded, and to become hidden again when the cell collapse. 
    // we just changed the “isVisible” value of some cells, and that means that the total number of visible rows have changed as well. So, before we reload the tableview, we must ask the app to find the index values of the visible rows from scratch
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        
        if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpandable"] as! Bool == true {
            var shouldExpandAndShowSubRows = false
            if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpanded"] as! Bool == false {
                // In this case the cell should expand.
                shouldExpandAndShowSubRows = true
            }
            cellDescriptors[indexPath.section][indexOfTappedRow].setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")
            
            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + (cellDescriptors[indexPath.section][indexOfTappedRow]["additionalRows"] as! Int)) {
                cellDescriptors[indexPath.section][i].setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
            }
        } else {
            /*
             Inside the inner if case we’ll perform four distinct tasks:
             
             1. We’ll find the row index of the top-level cell that is supposed to be the “parent” cell of the tapped one. In truth, we’ll perform a search towards the beginning of the cell descriptors and the first top-level cell that is spotted (the first cell that is expandable) is the one we want.
             2. We’ll set the displayed value of the selected cell as the text of the textLabel label of the top-level cell.
             3. We’ll mark the top-level cell as not expanded.
             4. We’ll mark all the sub-cells of the found top-level one as not visible.
             */
            if cellDescriptors[indexPath.section][indexOfTappedRow]["cellIdentifier"] as! String == "idCellValuePicker" {
                var indexOfParentCell: Int!
                for var i = indexOfTappedRow - 1; i >= 0; --i {
                    if cellDescriptors[indexPath.section][i]["isExpandable"] as! Bool == true {
                        indexOfParentCell = i
                        break
                    }
                }
                cellDescriptors[indexPath.section][indexOfParentCell].setValue((tblExpandable.cellForRowAtIndexPath(indexPath) as! CustomCell).textLabel?.text, forKey: "primaryTitle")
                cellDescriptors[indexPath.section][indexOfParentCell].setValue(false, forKey: "isExpanded")
            }
        }
        getIndicesOfVisibleRows()
        tblExpandable.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}











































