//
//  DataManager.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 11.03.2021.
//

import UIKit

protocol UpdateDataDelegate {
    func update()
}

class DataManager {
    
    static let shared = DataManager()
    
    let averageGlobalMonthlyEmission: CGFloat = 400.0
    
    var delegate: UpdateDataDelegate?
    
    var carbonData: [EditData.Carbon] = [] {
        didSet {
            saveCarbonToDB()
            delegate?.update()
        }
    }
    
    var targetSettings: TargetSettings.EmissionValues? {
        didSet {
            if targetSettings != nil {
                saveSettingsToDB()
            }
        }
    }
    
    func load() {
        
        loadCarbonFromDB()
        loadSettingsFromDB()
        
    }
    
    func saveCarbonToDB(completion: (() -> Void)? = nil) {
        if let encoded = try? JSONEncoder().encode(carbonData) {
            UserDefaults.standard.set(encoded, forKey: "SavedCarbonData")
        } else {
            print("Can't save data to DB")
        }
        completion?()
    }
    
    func loadCarbonFromDB(completion: (() -> Void)? = nil) {
        if let data = UserDefaults.standard.data(forKey: "SavedCarbonData") {
            if let decoded = try? JSONDecoder().decode([EditData.Carbon].self, from: data) {
                self.carbonData = decoded
                completion?()
                return
            }
        }
        
        print("Can't load data from DB")
        self.carbonData = []
        completion?()
    }
    
    func saveSettingsToDB(completion: (() -> Void)? = nil) {
        if let encoded = try? JSONEncoder().encode(targetSettings) {
            UserDefaults.standard.set(encoded, forKey: "SavedSettingsData")
        } else {
            print("Can't save data to DB")
        }
        completion?()
    }
    
    func loadSettingsFromDB(completion: (() -> Void)? = nil) {
        if let data = UserDefaults.standard.data(forKey: "SavedSettingsData") {
            if let decoded = try? JSONDecoder().decode((TargetSettings.EmissionValues).self, from: data) {
                self.targetSettings = decoded
                completion?()
                return
            }
        }
        
        print("Can't load data from DB")
        self.targetSettings = nil
        completion?()
    }
    
    func calculateUserEmission() -> CGFloat {
        
        CGFloat(carbonData.reduce(into: 0.0){ $0 += $1.calcEmission(days: 3) })
        
    }

}
