//
//  EditDataViewModel.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 01.03.2021.
//

import Foundation

class EditDataViewModel {
    
    var data: [EditData.Carbon] = []
    
    init() {
        
    }
    
    func makeDummyData(completion: (() -> Void)? = nil) {
        
        let carbon1 = EditData.Carbon(transport: .Bus, frequency: .EveryDay)
        let carbon2 = EditData.Carbon(transport: .Train, frequency: .Week(times: 2))
        let carbon3 = EditData.Carbon(transport: .Plane, frequency: .Month(times: 5))
        
        data = [carbon1, carbon2, carbon3]
        
        completion?()
        
    }
    
    func calculation() {
        
        print(data.reduce(into: 0.0){ $0 += $1.calcEmission(days: 3) })
        
    }
    
    func addData(carbon: EditData.Carbon) {
        data.append(carbon)
    }
    
    func updateData(carbonPair: (Int, EditData.Carbon)) {
        if carbonPair.0 < data.count {
            data[carbonPair.0] = carbonPair.1
        }
    }
    
    func deleteData(at indexPath: IndexPath) {
        if indexPath.row < data.count {
            data.remove(at: indexPath.row)
        }
    }
}


