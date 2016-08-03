//
//  GridView.swift
//  FinalAssignment
//
//  Created by Kaitlyn Li on 7/30/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    
    @IBInspectable var livingColor : UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor : UIColor = UIColor.blueColor()
    @IBInspectable var bornColor : UIColor = UIColor.greenColor()
    @IBInspectable var diedColor : UIColor = UIColor.grayColor()
    @IBInspectable var gridColor : UIColor = UIColor.blackColor()
    @IBInspectable var gridWidth : CGFloat = 2.0
    var grid: Grid = Grid (rows:10, cols:10)
    var points: [(Int, Int)] {
        get {
            var current = [(Int, Int)]()
            for row in 0..<grid.rows {
                for col in 0..<grid.cols {
                    if grid[row, col].isLiving() {
                        current.append ((row, col))
                    }
                }
            }
            return current
        }
        set (new){
            /*Find the max row and col in the points; If max row and col is greater than current grid rows and cols,
             *round up max row and col to get new rows and cols.
             */
            let maxRow = new.reduce(0) { $1.0 > $0 ? $1.0 : $0}
            let maxCol = new.reduce(0) { $1.1 > $0 ? $1.1 : $0}
            let rows = maxRow < grid.rows ? grid.rows : (maxRow + 9 )/10 * 10
            let cols = maxCol < grid.cols ? grid.cols : (maxCol + 9)/10 * 10
            grid = Grid (rows: rows, cols: cols)
            for point in new {
                grid[point.0 - 1 , point.1 - 1] = .Living
            }
        }
    }

    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    override func drawRect(rect: CGRect) {
        
        let rows = grid.rows
        let cols = grid.cols
        let cellWidth = bounds.width / CGFloat(cols)
        let cellHeight = bounds.height / CGFloat(rows)
        
        if rect.width <= cellWidth { //draw affected cell only
            let row = Int (rect.origin.y / cellHeight)
            let col = Int (rect.origin.x / cellWidth)
            drawCell(row, column:col, width: cellWidth, height: cellHeight)
        }
        else { //draw everything
            //draw grid
            let gridPath = UIBezierPath()
            gridColor.setStroke()
            gridPath.lineWidth = gridWidth
            for row in 0...rows {
                let rowY = cellHeight * CGFloat(row)
                gridPath.moveToPoint ((CGPoint(x:0, y:rowY)))
                gridPath.addLineToPoint(CGPoint(x:bounds.width, y:rowY))
            }
            for col in 0...cols {
                let colX = cellWidth * CGFloat(col)
                gridPath.moveToPoint ((CGPoint(x:colX, y:0)))
                gridPath.addLineToPoint(CGPoint(x:colX, y:bounds.height))
            }
            gridPath.stroke()
            
            //draw all cells
            for row in 0..<rows {
                for col in 0..<cols {
                    drawCell (row, column: col, width: cellWidth, height: cellHeight)
                }
            }
        }
    }
    private func drawCell (row:Int, column:Int, width: CGFloat, height: CGFloat){
        
        let cellRadius = min (width / 2.0, height / 2.0) * 0.6
        let cellCenterX = width * CGFloat(column) + width / 2.0
        let cellCenterY = height * CGFloat (row)  + height / 2.0
        let cellPath = UIBezierPath(arcCenter: CGPoint (x:cellCenterX, y:cellCenterY), radius: cellRadius, startAngle: 0.0, endAngle: CGFloat(2.0 * M_PI), clockwise: false)
        switch grid[row, column] {
        case .Living:
            livingColor.setFill()
        case .Born:
            bornColor.setFill()
        case .Empty:
            emptyColor.setFill()
        case .Died:
            diedColor.setFill()
        }
        cellPath.fill()
    }
    
    //Handle touch event
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let rows = grid.rows
        let cols = grid.cols
        let cellWidth = bounds.width / CGFloat (cols)
        let cellHeight = bounds.height / CGFloat (rows)
        
        let touch = touches.first as UITouch!
        let point = touch.locationInView(self)
        let row = Int (point.y / cellHeight)
        let col = Int (point.x / cellWidth)
        grid[row, col] = grid[row, col].toggle()
        self.setNeedsDisplayInRect(CGRect(x:cellWidth * CGFloat(col) + gridWidth/2, y:cellHeight * CGFloat(row) + gridWidth/2, width:cellWidth - gridWidth, height:cellHeight - gridWidth))
    }
}

