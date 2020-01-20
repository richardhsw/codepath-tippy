//
//  SettingsViewController.swift
//  tippy
//
//  Created by Richard Hsu on 2020/1/19.
//  Copyright © 2020 Richard Hsu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipSelect: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get default tip amount
        let defaults   = UserDefaults.standard
        let defaultTip = defaults.integer(forKey: "default tip")
        tipSelect.selectedSegmentIndex = defaultTip
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = UserDefaults.standard
        
        defaults.set(tipSelect.selectedSegmentIndex, forKey: "default tip")
        defaults.synchronize()
    }
}
