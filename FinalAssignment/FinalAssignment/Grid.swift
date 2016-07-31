//
//  Grid.swift
//  FinalAssignment
//
//  Created by Kaitlyn Li on 7/30/16.
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
    var cells: [CellState]
    
    required init (rows: Int, cols: Int){
        self.rows = rows
        self.cols = cols
        cells = [CellState] (count:rows * cols, repeatedValue:.Empty)
    }
    
    func neighbors(cell: (Int, Int)) -> [(Int, Int)]{
        let neighbors = [(-1, -1), (0, -1), (1,-1), (-1,0), (1,0), (-1, 1), (0, 1), (1,1)]
        return neighbors.map { (($0.0 + cell.0 + rows) % rows, ($0.1 + cell.1 + cols) % cols) }
    }
    
    func indexIsValid(row: Int, col: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < cols
    }
    
    subscript (row:Int, col:Int) -> CellState {
        get {
            assert(indexIsValid(row, col: col), "Index out of range")
            return cells[row*cols+col]
        }
        set {
            assert(indexIsValid(row, col: col), "Index out of range")
            cells[row*cols+col] = newValue
        }
    }
    
    func cellStateCount() -> (Int, Int, Int, Int){
        let livingCount = cells.reduce(0) {$1 == .Living ? $0 + 1 : $0}
        let bornCount = cells.reduce(0) {$1 == .Born ? $0 + 1 : $0}
        let diedCount = cells.reduce(0) {$1 == .Died ? $0 + 1 : $0}
        let emptyCount = cells.reduce(0) {$1 == .Empty ? $0 + 1 : $0}
        return (livingCount, bornCount, diedCount, emptyCount)
    }
}

