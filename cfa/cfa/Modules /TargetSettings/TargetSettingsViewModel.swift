//
//  TargetSettingsViewModel.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 11.03.2021.
//

import Foundation

class TargetSettingsViewModel {
    
    let dm = DataManager.shared
    
    func saveTarget(emission: Float) {
        
        let model = TargetSettings.EmissionValues(emission: emission)
        
    }
    
}
