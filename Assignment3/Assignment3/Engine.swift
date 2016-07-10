//
//  Engine.swift
//  Assignment3
//
//  Created by Kaitlyn Li on 7/10/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import Foundation

func step (before: [[CellState]]) -> [[CellState]] {
    
    let rows = before.count
    let cols = before[0].count
    var after = [[CellState]] (count:rows, repeatedValue:[CellState](count:cols, repeatedValue:.Empty))
    for row in 0..<rows {
        for col in 0..<cols {
            var neighborCount = 0
            for cell in neighbors((row, col), rows:rows, cols:cols){
                if before[cell.0][cell.1] == .Living || before[cell.0][cell.1] == .Born{
                    neighborCount+=1
                }
            }
            switch neighborCount {
            case 0..<2:
                if before[row][col] == .Living || before[row][col] == .Born{
                    after[row][col] = .Died
                }
                if before[row][col] == .Died {
                    after[row][col] = .Empty
                }
            case 2:
                if before[row][col] == .Living || before[row][col] == .Born {
                    after[row][col] = .Living
                }
                if before[row][col] == .Died {
                    after[row][col] = .Empty
                }
            case 3:
                if before[row][col] == .Living || before[row][col] == .Born{
                    after[row][col] = .Living
                }
                if before[row][col] == .Died || before[row][col] == .Empty{
                    after[row][col] = .Born
                }
            default:
                if before[row][col] == .Living || before[row][col] == .Born {
                    after[row][col] = .Died
                }
                if before[row][col] == .Died {
                    after[row][col] =  .Empty
                }
            }
            
        }
    }
    return after
}


func neighbors(cell: (Int, Int), rows:Int, cols: Int) -> [(Int, Int)]{
    
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
