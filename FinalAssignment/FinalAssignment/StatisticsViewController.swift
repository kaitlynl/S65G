//
//  StatisticsViewController.swift
//  FinalAssignment
//
//  Created by Kaitlyn Li on 7/30/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    var engine: StandardEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        engine = StandardEngine.sharedInstance
        displayCellCount (engine.grid)
        let sel = #selector(StatisticsViewController.actOnGridChangeNotification(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: "GridChangeNotification", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func actOnGridChangeNotification (notification:NSNotification){
        let grid = notification.object as! Grid
        displayCellCount (grid)
    }
    

    @IBOutlet weak var livingCount: UILabel!
    @IBOutlet weak var bornCount: UILabel!
    @IBOutlet weak var deadCount: UILabel!
    @IBOutlet weak var emptyCount: UILabel!
    
    func displayCellCount (grid:Grid) {
        let count: (Int, Int, Int, Int) = grid.cellStateCount()
        livingCount.text = "Living cell count: \(count.0)"
        bornCount.text = "Born cell count: \(count.1)"
        deadCount.text = "Died cell count: \(count.2)"
        emptyCount.text = "Empty cell count: \(count.3)"
    }
}
