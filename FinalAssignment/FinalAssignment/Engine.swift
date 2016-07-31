//
//  Engine.swift
//  FinalAssignment
//
//  Created by Kaitlyn Li on 7/30/16.
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
            delegate?.engineDidUpdate(grid)
            let notification = NSNotification(name: "GridChangeNotification", object: grid, userInfo: nil)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    var rows:Int = 10 {
        didSet {
            grid = Grid (rows:rows, cols:cols)
        }
    }
    var cols:Int = 10 {
        didSet {
            grid = Grid (rows:rows, cols:cols)
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
        let newGrid = Grid (rows:rows, cols:cols)
        newGrid.cells = (0..<rows*cols).map {
            let row = $0/cols
            let col = $0%cols
            let neighborCount = grid.neighbors((row, col)).reduce(0){ grid[$1.0, $1.1].isLiving() ? $0+1: $0}
            switch neighborCount {
            case 2:
                if grid[row, col].isLiving() { return .Living}
            case 3:
                if grid[row, col].isLiving() { return .Living} else { return .Born }
            default:
                if grid[row, col].isLiving() { return .Died}
            }
            return .Empty
        }
        return newGrid
    }
    
    func reset () -> Grid {
        return Grid (rows:rows, cols:cols)
    }
}

