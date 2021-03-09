//
//  EditDataModel.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 01.03.2021.
//

import Foundation

enum EditData {
    
    enum Transport: String, CaseIterable {
        
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
        
        var title: String {
            self.rawValue
        }
        
        static var count: Int {
            Transport.allCases.count
        }
        
        static var titles: [String] {
            Transport.allCases.map({ $0.rawValue })
        }
        
        static func get(by id: Int) -> Transport {
            Transport.allCases[id]
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
        
        var times: Int {
            switch self {
            case .EveryDay: return 1
            case .Week(let times): return times
            case .Month(let times): return times
            }
        }
        
        static var count: Int {
            3
        }
        
        static var titles: [String] {
            ["Every day", "week", "month"]
        }
        
        static func count(frequency: Frequency?) -> Int {
            guard let frequency = frequency else { return 0 }
            
            switch frequency {
            case .EveryDay: return 31
            case .Week(_): return 7
            case .Month(_): return 31
            }
        }
        
        static func get(by name: String, for times: Int = 1) -> Frequency {
            switch name {
            case "Every day": return .EveryDay
            case "week": return .Week(times: times)
            case "month": return .Month(times: times)
            default:
                return .EveryDay
            }
        }
        
        static func get(by frequency: Frequency, for times: Int = 1) -> Frequency {
            switch frequency {
            case .EveryDay: return .EveryDay
            case .Week(_): return .Week(times: times)
            case .Month(_): return .Month(times: times)
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
