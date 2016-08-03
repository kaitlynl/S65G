//
//  InstrumentationViewController.swift
//  FinalAssignment
//
//  Created by Kaitlyn Li on 7/30/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    
    var engine: StandardEngine!
    var jsonData = [(String,[[Int]])]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        engine = StandardEngine.sharedInstance
        let sel = #selector(InstrumentationViewController.actOnSimulationSaveNotification(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: "SimulationSaveNotification", object: nil)
    }
    
    func actOnSimulationSaveNotification (notification:NSNotification){
        guard let userInfo = notification.userInfo,
            let title = userInfo["title"] as? String,
            let contents = userInfo["contents"] as? [[Int]] else {return}
        jsonData.append((title, contents))
        let itemRow = jsonData.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableViewOutlet.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell!
            else {
                preconditionFailure ("missiong cell reuse identifier")
        }
        let row = indexPath.row
        cell.textLabel?.text = jsonData[row].0
        cell.detailTextLabel?.text = "\(jsonData[row].1)"
        cell.tag = row
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            jsonData.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        let editingTitle = jsonData[editingRow].0
        let editingContents = jsonData[editingRow].1
        let editingVC = segue.destinationViewController as! GridEditorViewController
        editingVC.currentTitle = editingTitle
        editingVC.currentContents = editingContents
        editingVC.save = {
            self.jsonData[editingRow].0 = $0
            self.jsonData[editingRow].1 = $1
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableViewOutlet.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            //after save to table, reset engine grid to current configuration
            let points  = self.jsonData[editingRow].1.map {($0[0], $0[1])}
            self.setEngineGridWithConfiguration(points)
            let newGrid = self.engine.reset()
            for point in points {
                newGrid[point.0, point.1] = .Living
            }
            self.engine.grid = newGrid
        }
    }
    
    func setEngineGridWithConfiguration(points: [(Int, Int)]){
        /*find the max row and col in the points, if max row and col less than engine rows and cols,
         *update grid with points; otherwise also update engine rows and cols with round up max row and col
         */
        let maxRow = points.reduce(0) { $1.0 > $0 ? $1.0 : $0}
        let maxCol = points.reduce(0) { $1.1 > $0 ? $1.1 : $0}
        if maxRow > engine.rows {
            engine.rows = (maxRow + 9 )/10 * 10
            rowsOutlet.text = String (engine.rows)
            rowsStepOutlet.value = Double (engine.rows)
        }
        if maxCol > engine.cols {
            engine.cols = (maxCol + 9)/10 * 10
            colsOutlet.text = String (engine.cols)
            colsStepOutlet.value = Double (engine.cols)
        }
        let newGrid = engine.reset()
        for point in points {
            newGrid[point.0 - 1 , point.1 - 1] = .Living
        }
        engine.grid = newGrid
    }
    
 
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBAction func addTableCell(sender: UIBarButtonItem) {
        jsonData.append(("New row...", [[Int]]()))
        let itemRow = jsonData.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableViewOutlet.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    @IBOutlet weak var jsonUrlOutlet: UITextField!
    @IBAction func reloadAction(sender: UIButton) {
        // let nsurl = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")
        let nsurl = NSURL(string: jsonUrlOutlet.text!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 30.0
        let task = NSURLSession(configuration: config).dataTaskWithURL(nsurl!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if error != nil {
                print ("NSURLSession error = \(error)")
                return
            }
            else  {
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                if statusCode == 200 {
                    self.jsonData = [(String, [[Int]])]()
                    do {
                        let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        guard let items = object as? [AnyObject] else {return}
                        for item in items {
                            guard let title = item["title"] as? String,
                                let contents = item["contents"] as? [[Int]] else {return}
                            self.jsonData.append ((title, contents))
                        }
                        let op = NSBlockOperation {
                            self.tableViewOutlet.reloadData()
                        }
                        NSOperationQueue.mainQueue().addOperation(op)
                    }catch {
                        print ("JSON serialization failed: \(error)")
                    }
                }
                else {
                    print ("HTTP error \(statusCode)")
                }
            }
        }
        task.resume()
    }
    
    @IBOutlet weak var rowsStepOutlet: UIStepper!
    @IBOutlet weak var colsStepOutlet: UIStepper!
    @IBOutlet weak var rowsOutlet: UITextField!
    @IBOutlet weak var colsOutlet: UITextField!
    @IBAction func rowsStepAction(sender: UIStepper) {
        engine.rows = Int (sender.value)
        rowsOutlet.text = String (engine.rows)
    }
    @IBAction func colsStepAction(sender: UIStepper) {
        engine.cols = Int (sender.value)
        colsOutlet.text = String (engine.cols)
    }
    @IBOutlet weak var refreshSliderOutlet: UISlider!
    @IBOutlet weak var refreshSwitchOutlet: UISwitch!
    @IBAction func refreshSliderAction(sender: UISlider) {
        if refreshSwitchOutlet.on {
            engine.refreshRate = Double (sender.value)
        }
        else {
            engine.refreshRate = 0
        }
    }
    @IBAction func refreshSwtichAction(sender: UISwitch) {
        if sender.on  {
            engine.refreshRate = Double(refreshSliderOutlet.value)
        }
        else {
            engine.refreshRate = 0
        }
    }
}

