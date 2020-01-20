//
//  ViewController.swift
//  tippy
//
//  Created by Richard Hsu on 2020/1/10.
//  Copyright © 2020 Richard Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var overrideDefaultTip = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Possibly get default bill amount and tip index
        let defaults = UserDefaults.standard
        let prev_time = defaults.object(forKey: "last opened") as? NSDate
        if (prev_time != nil && prev_time!.timeIntervalSinceNow < 10 * 60) {
            billField.text = defaults.string(forKey: "saved bill")
            overrideDefaultTip = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get default tip amount
        let defaults   = UserDefaults.standard
        let defaultTip = defaults.integer(forKey: "default tip")
        
        if (overrideDefaultTip) {
            overrideDefaultTip = false
            tipControl.selectedSegmentIndex = defaults.integer(forKey: "saved tip")
        }
        else {
            tipControl.selectedSegmentIndex = defaultTip
        }
        
        calculateTip(tipControl as Any)
        
        // User only edits the textfield
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Save bill amount
        let defaults = UserDefaults.standard
        defaults.set(billField.text, forKey: "saved bill")
        
        // Save current time
        let time = NSDate()
        defaults.set(time, forKey: "last opened")
        
        // Save current tip value
        defaults.set(tipControl.selectedSegmentIndex, forKey: "saved tip")
    }
    
    func getBill() -> Double {
        let billText = billField.text ?? ""
        if billText.starts(with: "$") {
            return Double(billText.suffix(billText.count - 1)) ?? 0
        }
        else {
            return Double(billField.text!) ?? 0
        }
    }

    @IBAction func onTap(_ sender: Any) {
        // view.endEditing(true)
        
        // Format bill field text
        let bill = getBill()
        billField.text = String(format: "$%.2f", bill)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get bill amount
        let bill = getBill()
        
        // Calculate tip and total
        let tipPercentages = [0.15, 0.18, 0.2]
        let tip   = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Update the tip and total labels
        tipLabel.text   = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

