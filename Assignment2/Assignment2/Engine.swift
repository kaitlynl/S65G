//
//  Engine.swift
//  Assignment2
//
//  Created by Kaitlyn Li on 7/2/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import Foundation

let rows = 10
let cols = 10

func initial( ) -> [[Bool]] {
    
    var before = [[Bool]] (count:rows, repeatedValue:[Bool](count:cols, repeatedValue:false))
    for row in 0..<rows {
        for col in 0..<cols {
            if arc4random_uniform(3) == 1 {
                before[row][col] = true
            }
        }
    }
    return before
}

func step(before: [[Bool]]) -> [[Bool]] {
    
    var after = [[Bool]] (count:rows, repeatedValue:[Bool](count:cols, repeatedValue:false))
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
                }
            case 3:
                after[row][col] = true
            default:
                after[row][col] = false
            }
            
        }
    }
    return after
}

func step2(before: [[Bool]]) -> [[Bool]] {
    
    var after = [[Bool]] (count:rows, repeatedValue:[Bool](count:cols, repeatedValue:false))
    for row in 0..<rows {
        for col in 0..<cols {
            var neighborCount = 0
            for cell in neighbors((row, col)){
                if before[cell.0][cell.1] {
                    neighborCount+=1
                }
            }
            switch neighborCount {
            case 0..<2:
                after[row][col] = false
            case 2:
                if before[row][col] {
                    after[row][col] = true
                }
            case 3:
                after[row][col] = true
            default:
                after[row][col] = false
            }
            
        }
    }
    return after
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
    //  print ("test: \(neighbors)")
    return neighbors
}

