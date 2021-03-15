//
//  TargetSettingsViewModel.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 11.03.2021.
//

import UIKit

class TargetSettingsViewModel {
    
    let dm = DataManager.shared
    
    func saveTarget(emission: CGFloat) {
        
        let model = TargetSettings.EmissionValues(emission: emission)
        
        dm.targetSettings = model
        
    }
    
}
