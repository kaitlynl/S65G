//
//  SimulationViewController.swift
//  FinalAssignment
//
//  Created by Kaitlyn Li on 7/30/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegateProtocol {
    
    var engine: StandardEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        engine = StandardEngine.sharedInstance
        engine.delegate = self
        gridViewOutlet.grid = engine.grid
        let sel = #selector(SimulationViewController.actOnTimerFireNotification(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: "TimerFireNotification", object: nil)

    }
    
    func actOnTimerFireNotification (notification:NSNotification){
        engine.grid = engine.step()
    }
    
    func engineDidUpdate (withGrid:Grid) {
        gridViewOutlet.grid = withGrid
        gridViewOutlet.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var gridViewOutlet: GridView!
    
    @IBAction func stepAction(sender: UIButton) {
        engine.grid = engine.step()
    }
    
    @IBAction func resetAction(sender: UIButton) {
        engine.grid = engine.reset()
    }
    
    @IBAction func saveAction(sender: UIButton) {
        let alert=UIAlertController(title: "Save current grid", message: "Please enter configuration title", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
            let fields = alert.textFields!
            let title = fields[0].text!
            let contents: [[Int]] = self.gridViewOutlet.points.map { [$0.0, $0.1] }
            let userInfo = ["title": title, "contents": contents] as [NSObject: AnyObject]
            let notification = NSNotification(name: "SimulationSaveNotification", object: nil, userInfo: userInfo)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }))
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

