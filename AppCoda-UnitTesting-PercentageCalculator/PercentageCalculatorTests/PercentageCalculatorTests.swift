//
//  PercentageCalculatorTests.swift
//  PercentageCalculatorTests
//
//  Created by Maxime Defauw on 03/02/16.
//  Copyright © 2016 App Coda. All rights reserved.
//

import XCTest
@testable import PercentageCalculator

class PercentageCalculatorTests: XCTestCase {
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        vc = storyboard.instantiateInitialViewController() as! ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // The comparison ‘to what we expect it to be’ part is handled by XCTAssert functions. The simplest XCTAssert function is the XCTAssert(expression: BooleanType). This one takes in a boolean expression (This can be something like 5 > 3, 8.90 == 8.90 or true) and makes the test pass if the expression is evaluated to be true or fail if evaluated to be false.
    func testPercentageCalculator() {
        // Should be 25
        let p = vc.percentage(50, 50)
        XCTAssert(p == 25)
    }
    /*
     The thing is that I created these labels in my storyboard file and thus they are instantiated once the view is loaded, but since for Unit Tests the loadView() method is never triggered, the labels are not created and thus they are nil. A possible solution for this problem is to call vc.loadView(), but Apple doesn’t recommend doing this in its documentation as it may cause memory leaks when objects that have already been loaded are loaded again.
     
     Instead, you should access the view property of vc, which will in its turn trigger all the required methods, and not simply the loadView() method.
    */
    func testLabelValuesShowedProperly() {
        let _ = vc.view
        vc.updateLabels(Float(80.0), Float(50.0), Float(40.0))
        
        // The labels should now display 80, 50, and 40
        XCTAssert(vc.numberLabel.text == "80.0", "numberLabel doesn't show the right text")
        XCTAssert(vc.percentageLabel.text == "50.0%", "percentageLabel doesn't show the right text")
        XCTAssert(vc.resultLabel.text == "40.0", "resultLabel doesn't show the right text")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
