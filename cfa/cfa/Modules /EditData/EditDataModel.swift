//
//  EditDataModel.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 01.03.2021.
//

import Foundation

enum EditData {
    
    enum Transport {
        
        case Train
        case Car
        case Bus
        case Plane
        
        var averageEmission: Float {
            switch self {
            case .Train: return 0.4061
            case .Car: return 1.701
            case .Bus: return 0.1633
            case .Plane: return 256.4
            }
        }
    }
    
    enum Frequency {
        
        case EveryDay
        case Week(days: Int)
        case Month(weeks: Int)
        
    }
    
    struct Carbon {
        
        let transport: Transport
        let frequency: Frequency
        
    }
    
    
}
