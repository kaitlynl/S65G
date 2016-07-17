//
//  Engine.swift
//  Assignment4
//
//  Created by Kaitlyn Li on 7/17/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import Foundation

protocol EngineProtocol {
    
    var delegate: EngineDelegateProtocol? {get set}
    var grid: Grid {get}
    var rows:Int {get set}
    var cols:Int {get set}
    var refreshTimer: NSTimer {get set}
    var refreshRate: Double {get set}
    
    init (rows: Int, cols:Int)
    func step() -> Grid
}

class StandardEngine: EngineProtocol {
    
    private static var _sharedInstance = StandardEngine(rows:10, cols:10)
    static var sharedInstance: StandardEngine {
        get {
            return _sharedInstance
        }
    }
    
    var delegate: EngineDelegateProtocol?
    var grid:Grid {
        didSet {
            let notification = NSNotification(name: "GridChangeNotification", object: grid, userInfo: nil)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    var rows:Int = 10 {
        didSet {
            grid = Grid (rows:rows, cols:cols)
            delegate?.engineDidUpdate(grid)
        }
    }
    var cols:Int = 10 {
        didSet {
            grid = Grid (rows:rows, cols:cols)
            delegate?.engineDidUpdate(grid)
        }
    }
    
    var refreshTimer: NSTimer = NSTimer()
    var refreshRate: Double = 0 {
        didSet {
            if refreshRate != 0 {
                refreshTimer.invalidate()
                let sel = #selector(StandardEngine.timerDidFire(_:))
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(1/refreshRate, target: self, selector: sel, userInfo: nil, repeats: true)
            }
            else {
                refreshTimer.invalidate()
            }
        }
    }
    @objc func timerDidFire(timer:NSTimer) {
        let notification = NSNotification(name: "TimerFireNotification", object: nil, userInfo: nil)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    required init (rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Grid(rows:rows, cols:cols)
    }
    
    func step () -> Grid {
        
        let nextGrid = Grid (rows:rows, cols:cols)
        for row in 0..<rows {
            for col in 0..<cols {
                var neighborCount = 0
                for cell in grid.neighbors((row, col)){
                    if grid[cell.0, cell.1] == .Living || grid[cell.0, cell.1] == .Born{
                        neighborCount+=1
                    }
                }
                switch neighborCount {
                case 0..<2:
                    if grid[row, col] == .Living || grid[row, col] == .Born{
                        nextGrid[row,col] = .Died
                    }
                case 2:
                    if grid[row, col] == .Living || grid[row, col] == .Born {
                        nextGrid[row, col] = .Living
                    }
                case 3:
                    if grid[row, col] == .Living || grid[row, col] == .Born{
                        nextGrid[row, col] = .Living
                    }
                    if grid[row, col] == .Died || grid[row, col] == .Empty{
                        nextGrid[row, col] = .Born
                    }
                default:
                    if (grid[row, col] == .Living) || grid[row, col] == .Born {
                        nextGrid[row, col] = .Died
                    }
                }
            }
        }
        return nextGrid
    }
}
