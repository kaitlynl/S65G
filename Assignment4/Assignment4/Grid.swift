//
//  Grid.swift
//  Assignment4
//
//  Created by Kaitlyn Li on 7/17/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import Foundation

protocol GridProtocol {
    
    var rows: Int { get }
    var cols: Int { get }
    
    init (rows: Int, cols: Int)
    func neighbors(cell: (Int, Int)) -> [(Int, Int)]
    subscript (row:Int, col:Int)->CellState {get set}
}


class Grid: GridProtocol {
    
    var rows: Int
    var cols: Int
    var cells: [[CellState]]
    
    required init (rows: Int, cols: Int){
        self.rows = rows
        self.cols = cols
        cells = [[CellState]] (count:rows, repeatedValue:[CellState](count:cols, repeatedValue:.Empty))
    }
    
    func neighbors(cell: (Int, Int)) -> [(Int, Int)]{
        
        var neighbors = [(Int, Int)]()
        for r in cell.0 - 1...cell.0 + 1 {
            for c in cell.1 - 1...cell.1 + 1 {
                if !(r==cell.0 && c==cell.1) {
                    switch (r, c) {
                    case (-1, -1):
                        neighbors.append ((rows-1, cols-1))
                    case (rows, cols):
                        neighbors.append ((0, 0))
                    case (-1, cols):
                        neighbors.append ((rows-1, 0))
                    case (rows, -1):
                        neighbors.append ((0, cols-1))
                    case (-1, 0..<cols):
                        neighbors.append ((rows-1, c))
                    case (0..<rows, -1):
                        neighbors.append ((r, cols-1))
                    case (rows, 0..<cols):
                        neighbors.append ((0, c))
                    case (0..<rows, cols):
                        neighbors.append ((r, 0))
                    default:
                        neighbors.append ((r, c))
                    }
                }
            }
        }
        return neighbors
    }
    
    
    func indexIsValid(row: Int, col: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < cols
    }
    
    subscript (row:Int, col:Int) -> CellState {
        get {
            assert(indexIsValid(row, col: col), "Index out of range")
            return cells[row][col]
        }
        set {
            assert(indexIsValid(row, col: col), "Index out of range")
            cells[row][col] = newValue
        }
    }
    
    func cellStateCount() -> (Int, Int, Int, Int){
        var livingCount:Int = 0
        var bornCount:Int = 0
        var diedCount:Int = 0
        var emptyCount:Int = 0
        for row in 0..<rows {
            for col in 0..<cols {
                switch cells[row][col] {
                case .Living:
                    livingCount+=1
                case .Born:
                    bornCount+=1
                case .Died:
                    diedCount+=1
                case .Empty:
                    emptyCount+=1
                }
            }
        }
        return (livingCount, bornCount, diedCount, emptyCount)
    }
}