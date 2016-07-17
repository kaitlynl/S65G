//
//  FirstViewController.swift
//  Assignment4
//
//  Created by Kaitlyn Li on 7/17/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    
    var engine: StandardEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        engine = StandardEngine.sharedInstance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var rowsOutlet: UITextField!
    
    @IBOutlet weak var columnsOutlet: UITextField!
    
    @IBAction func rowsStepAction(sender: UIStepper) {
        engine.rows = Int (sender.value)
        rowsOutlet.text = String (engine.rows)
    }

    @IBAction func columnsStepAction(sender: UIStepper) {
        engine.cols = Int (sender.value)
        columnsOutlet.text = String (engine.cols)
    }
    
    
    
    @IBOutlet weak var refreshSliderOutlet: UISlider!
    @IBAction func refreshSliderAction(sender: UISlider) {
        if refreshSwitchOutlet.on{
            engine.refreshRate = Double (sender.value)
        }
        else{
            engine.refreshRate = 0
        }
    }
    
    @IBOutlet weak var refreshSwitchOutlet: UISwitch!
    @IBAction func refreshSwitchAction(sender: UISwitch) {
        if sender.on{
            engine.refreshRate = Double (refreshSliderOutlet.value)
        }
        else{
            engine.refreshRate = 0
        }
        
    }
    
}

