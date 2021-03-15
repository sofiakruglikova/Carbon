//
//  EditDataViewModel.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 01.03.2021.
//

import Foundation

class EditDataViewModel {
    
    let dm = DataManager.shared
    
    init() {
        
    }
    
    func makeDummyData(completion: (() -> Void)? = nil) {
        
        let carbon1 = EditData.Carbon(transport: .Bus, frequency: .EveryDay)
        let carbon2 = EditData.Carbon(transport: .Train, frequency: .Week(times: 2))
        let carbon3 = EditData.Carbon(transport: .Plane, frequency: .Month(times: 5))
        
        dm.carbonData = [carbon1, carbon2, carbon3]
        
        completion?()
        
    }
    
    func addData(carbon: EditData.Carbon) {
        dm.carbonData.append(carbon)
    }
    
    func updateData(carbonPair: (Int, EditData.Carbon)) {
        if carbonPair.0 < dm.carbonData.count {
            dm.carbonData[carbonPair.0] = carbonPair.1
        }
    }
    
    func deleteData(at indexPath: IndexPath) {
        if indexPath.row < dm.carbonData.count {
            dm.carbonData.remove(at: indexPath.row)
        }
    }
}


