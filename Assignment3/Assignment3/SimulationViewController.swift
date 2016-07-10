//
//  ViewController.swift
//  Assignment3
//
//  Created by Kaitlyn Li on 7/9/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var gridViewOutlet: GridView!
    
    @IBAction func Run(sender: UIButton) {
        gridViewOutlet.grid = step (gridViewOutlet.grid)
        gridViewOutlet.setNeedsDisplay()

    }
}

