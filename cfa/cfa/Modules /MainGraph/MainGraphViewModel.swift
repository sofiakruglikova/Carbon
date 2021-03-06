//
//  MainGraphViewModel.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 10.03.2021.
//

import UIKit

class MainGraphViewModel {
    
    private let dm = DataManager.shared
    
    func calcGraphData(completion: ((MainGraph.Values) -> Void)? = nil) {
        
        completion?(MainGraph.Values(userCarbon: dm.calculateUserEmission(),
                                     globalAverage: dm.averageGlobalMonthlyEmission,
                                     userTarget: dm.targetSettings?.emission ?? 0.0))
    }
    
}
