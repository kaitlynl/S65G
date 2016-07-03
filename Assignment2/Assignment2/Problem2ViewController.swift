//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Kaitlyn Li on 7/2/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Problem 2"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    @IBOutlet weak var problem2Output: UITextView!

    @IBAction func problem2Run(sender: UIButton) {
       // problem2Output.text = "Problem 2 run button was clicked"
        let rows = 10
        let cols = 10
        var before = [[Bool]] (count:rows, repeatedValue:[Bool](count:cols, repeatedValue:false))
        var beforeCount = 0
        for row in 0..<rows {
            for col in 0..<cols {
                if arc4random_uniform(3) == 1 {
                    before[row][col] = true
                    beforeCount+=1
                }
            }
        }
        
        var after = [[Bool]] (count:rows, repeatedValue:[Bool](count:cols, repeatedValue:false))
        var afterCount = 0
        for row in 0..<rows {
            for col in 0..<cols {
                var neighborCount = 0
                for r in row-1...row+1 {
                    for c in col-1...col+1 {
                        if !(r==row && c==col) {
                            switch (r, c) {
                            case (-1, -1):
                                if before[rows-1][cols-1]{
                                    neighborCount+=1
                                }
                            case (rows, cols):
                                if before[0][0]{
                                    neighborCount+=1
                                }
                            case (-1, cols):
                                if before[rows-1][0]{
                                    neighborCount+=1
                                }
                            case (rows, -1):
                                if before[0][cols-1]{
                                    neighborCount+=1
                                }
                                
                            case (-1, 0..<cols):
                                if before[rows-1][c]{
                                    neighborCount+=1
                                }
                            case (0..<rows, -1):
                                if before[r][cols-1]{
                                    neighborCount+=1
                                }
                            case (rows, 0..<cols):
                                if before[0][c]{
                                    neighborCount+=1
                                }
                            case (0..<rows, cols):
                                if before[r][0]{
                                    neighborCount+=1
                                }
                            default:
                                if before[r][c] {
                                    neighborCount+=1
                                }
                            }
                        }
                    }
                }
                switch neighborCount {
                case 0..<2:
                    after[row][col] = false
                case 2:
                    if before[row][col] {
                        after[row][col] = true
                        afterCount+=1
                    }
                case 3:
                    after[row][col] = true
                    afterCount+=1
                default:
                    after[row][col] = false
                }
                
            }
        }
        problem2Output.text = "Number of living cells count - Before: \(beforeCount); After: \(afterCount)"
    }
}
