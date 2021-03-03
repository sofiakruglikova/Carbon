//
//  EditDataModel.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 01.03.2021.
//

import Foundation

enum EditData {
    
    enum Transport: String {
        
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
        case Week(times: Int)
        case Month(times: Int)
        
        var text: String {
            switch self {
            case .EveryDay: return "Every Day"
            case .Week(let times): return "\(times) a week"
            case .Month(let times): return "\(times) a month"
            }
        }
        
    }
    
    struct Carbon {
        
        let date: Date = Date()
        
        let transport: Transport
        let frequency: Frequency
        
        var title: String {
            transport.rawValue
        }
        
        var subtitle: String {
            frequency.text
        }
        
        func calcEmission(days: Float = 30) -> Float {
            
            let emission = transport.averageEmission
            switch frequency {
            case .EveryDay: return days * emission
            case .Week(let times): return Float((days/7.0) * Float(times)) * emission
            case .Month(let times): return Float((days/(365.0/12.0)) * Float(times)) * emission
                
            }
        }
    }
    
    
}
