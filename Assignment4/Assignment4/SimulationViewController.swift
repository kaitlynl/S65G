//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Kaitlyn Li on 7/17/16.
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
        
        let sel = #selector(SimulationViewController.actOnTimerNotification(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: "TimerFireNotification", object: nil)
    }
    
    func actOnTimerNotification (notification:NSNotification){
        engine.grid = engine.step()
        gridViewOutlet.grid = engine.grid
        gridViewOutlet.setNeedsDisplay()
    }
    
    func engineDidUpdate(withGrid: Grid) {
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
        gridViewOutlet.grid = engine.grid
        gridViewOutlet.setNeedsDisplay()
        
    }
}

