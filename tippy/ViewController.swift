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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        view.endEditing(true)
        
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

