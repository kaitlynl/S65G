//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Kaitlyn Li on 7/17/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let sel = #selector(StatisticsViewController.actOnGridChangeNotification(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: "GridChangeNotification", object: nil)
    }

    
    func actOnGridChangeNotification (notification:NSNotification){
        let grid = notification.object as! Grid
        let count: (Int, Int, Int, Int) = grid.cellStateCount()
        livingCount.text = "Living cell count: \(count.0)"
        bornCount.text = "Born cell count: \(count.1)"
        deadCount.text = "Died cell count: \(count.2)"
        emptyCount.text = "Empty cell count: \(count.3)"
    }

    
    @IBOutlet weak var livingCount: UILabel!
    
    @IBOutlet weak var bornCount: UILabel!

    @IBOutlet weak var deadCount: UILabel!
    
    @IBOutlet weak var emptyCount: UILabel!
}
