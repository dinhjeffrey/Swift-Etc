//
//  ViewController.swift
//  PercentageCalculator
//
//  Created by Maxime Defauw on 03/02/16.
//  Copyright © 2016 App Coda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    // The top slider and a label, that represent the value of a number you want to calculate a percentage of.
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    
    // The second slider and a label, that represent the value of the percentage.
    @IBOutlet weak var percentageSlider: UISlider!
    @IBOutlet weak var percentageLabel: UILabel!
    
    // The lowest label, showing the percentage result.
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    // MARK: - Methods for UIElements
    // Called when the numberSlider value is changed. It will update its value to be a whole number and calculate and display the percentage results.
    @IBAction func numberValueChanged(sender: AnyObject) {
        numberSlider.setValue(Float(Int(numberSlider.value)), animated: true)
        
        let r = percentage(numberSlider.value, percentageSlider.value)
        updateLabels(numberSlider.value, nil, r)
    }
    
    // Called when the percentageSlider value is changed. It will update its value to be a whole number and calculate and display the percentage results.
    @IBAction func percentageValueChanged(sender: AnyObject) {
        percentageSlider.setValue(Float(Int(percentageSlider.value)), animated: true)
        
        let r = percentage(numberSlider.value, percentageSlider.value)
        updateLabels(nil, percentageSlider.value, r)
    }
    
    // This will update the all the labels when one of the two sliders values has been changed.
    func updateLabels(nV: Float?, _ pV: Float?, _ rV: Float) {
        if let v = nV {
            self.numberLabel.text = "\(v)"
        }
        if let v = pV {
            self.percentageLabel.text = "\(v)%"
        }
        
        self.resultLabel.text = "\(rV + 10)"
    }
    
    // MARK: - Percentage Calculation
    // This calculates the percentage result of two given numbers.
    func percentage(value: Float, _ percentage: Float) -> Float {
        return value * (percentage / 100)
    }
    
    
    
    // MARK: - System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

