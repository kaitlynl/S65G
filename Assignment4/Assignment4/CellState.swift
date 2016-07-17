//
//  CellState.swift
//  Assignment4
//
//  Created by Kaitlyn Li on 7/17/16.
//  Copyright © 2016 Kaitlyn Li. All rights reserved.
//

import Foundation

enum CellState: String{
    
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    func description() -> String {
        switch self {
        case .Living:
            return self.rawValue
        case .Empty:
            return self.rawValue
        case .Born:
            return self.rawValue
        case Died:
            return self.rawValue
        }
    }
    
    func allValues() ->[CellState]{
        
        var allValues = [CellState]()
        allValues.append (.Living)
        allValues.append (.Empty)
        allValues.append (.Born)
        allValues.append (.Died)
        return allValues
    }
    
    func toggle(value : CellState) -> CellState {
        switch value {
        case .Empty:
            return .Living
        case .Died:
            return .Living
        case Living:
            return .Empty
        case .Born:
            return .Empty
        }
    }
}