//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Kaitlyn Li on 7/2/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Problem 4"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var problem4Output: UITextView!
    
    @IBAction func problem4Run(sender: UIButton) {
       // problem4Output.text = "Problem4 Run button was clicked"
        
        var before = initial()
        var beforeCount = 0
        for row in 0..<before.count {
            for col in 0..<before[0].count {
                if before[row][col] {
                    beforeCount+=1
                }
            }
        }
        
        var after = step2 (before)
        var afterCount = 0
        for row in 0..<before.count {
            for col in 0..<before[0].count {
                if after[row][col] {
                    afterCount+=1
                }
            }
        }
        problem4Output.text = "Number of living cells count - Before: \(beforeCount); After: \(afterCount) "
    }
    
    }
    

