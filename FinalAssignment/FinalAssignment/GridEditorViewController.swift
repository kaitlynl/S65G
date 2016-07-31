//
//  GridEditorViewController.swift
//  FinalAssignment
//
//  Created by Kaitlyn Li on 7/30/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController {

    var engine: StandardEngine!
    var currentTitle:String?
    var currentContents:[[Int]] = [[Int]]()
    var save: ((String, [[Int]]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = StandardEngine.sharedInstance
        gridEditorOutlet.grid = engine.grid
        gridEditorOutlet.points  = currentContents.map {($0[0], $0[1])}
        titleOutlet.text = currentTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var titleOutlet: UITextField!
    @IBOutlet weak var gridEditorOutlet: GridView!

    @IBAction func saveAction(sender: UIBarButtonItem) {
        guard let newTitle = titleOutlet.text, save = save else {return}
        let newContents = gridEditorOutlet.points.map { [$0.0, $0.1] }
        save(newTitle, newContents)
        navigationController!.popViewControllerAnimated(true)
    }
    
}
