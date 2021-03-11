//
//  DataManager.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 11.03.2021.
//

import Foundation

protocol UpdateDataDelegate {
    func update()
}

class DataManager {
    
    static let shared = DataManager()
    
    var delegate: UpdateDataDelegate?
    
    var data: [EditData.Carbon] = [] {
        didSet {
            saveToDB()
            delegate?.update()
        }
    }
    
    init() {
        loadFromDB()
    }
    
    deinit {
        saveToDB()
    }
    
    func saveToDB(completion: (() -> Void)? = nil) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        } else {
            print("Can't save data to DB")
        }
        completion?()
    }
    
    func loadFromDB(completion: (() -> Void)? = nil) {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([EditData.Carbon].self, from: data) {
                self.data = decoded
                completion?()
                return
            }
        }
        
        print("Can't load data from DB")
        self.data = []
        completion?()
    }

}
