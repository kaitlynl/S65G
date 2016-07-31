//
//  CellState.swift
//  FinalAssignment
//
//  Created by Kaitlyn Li on 7/30/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import Foundation


enum CellState: String{
    
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    func description() -> String {
        return self.rawValue
    }
    
    func allValues() ->[CellState]{
        
        var allValues = [CellState]()
        allValues.append (.Living)
        allValues.append (.Empty)
        allValues.append (.Born)
        allValues.append (.Died)
        return allValues
    }
    
    func toggle() -> CellState {
        switch self {
        case .Empty, Died: return .Living
        case Living, Born: return .Empty
        }
    }
    
    func isLiving() -> Bool {
        switch self {
        case .Living, Born: return true
        case .Died, .Empty: return false
        }
    }
}
