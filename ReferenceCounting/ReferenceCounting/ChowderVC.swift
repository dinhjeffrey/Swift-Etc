//
//  ChowderVC.swift
//  ReferenceCounting
//
//  Created by jeffrey dinh on 6/30/16.
//  Copyright © 2016 jeffrey dinh. All rights reserved.
//

import UIKit

class ChowderVC: UIViewController {
    private var count = 0
    var model = Model()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ChowderVC"
        count += 1
        print("Loaded up a new MVC  (count is \(count))")
        model.add(1, num2: 4.4) {
            self.box.backgroundColor = UIColor.brownColor()
            self.model.dictionary["storedString"] = $0
            print("changing to brownColor and $0 is \($0)")
            print("dictionary is \(self.model.dictionary)")
            return ($0 + "SHOWER")
        }
    }
    
    deinit {
        count -= 1
        print("Left the heap  (count is \(count))")
    }
    
    @IBOutlet weak var box: UILabel!
    @IBOutlet weak var dictKeyLabel: UITextField!
    @IBAction func okPressed() {
        if let dictKey = dictKeyLabel.text {
            Model.key = dictKey
        }
        dictKeyLabel.text = ""
    }
    
}
