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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var problem4Output: UITextView!
    
    @IBAction func problem4Run(sender: UIButton) {
        problem4Output.text = "Problem4 Run button was clicked"
    }
    
}
