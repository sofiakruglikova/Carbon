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
        
        makeDummyData()
        
    }
    
    func makeDummyData() {
        
        let carbon1 = EditData.Carbon(transport: .Bus, frequency: .EveryDay)
        let carbon2 = EditData.Carbon(transport: .Train, frequency: .Week(days: 2))
        let carbon3 = EditData.Carbon(transport: .Plane, frequency: .Month(weeks: 5))
        
        data = [carbon1, carbon2, carbon3]
        
    }
    
}


