//
//  VehicleFilterViewModel.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-30.
//

import Foundation
import Combine

protocol FilteringViewModel {
//    var vehicleList: [VehicleCellModel] { get }
//    var vehicleMakeText: String { get }
//    var vehicleModelText: String { get }
}

class VehicleFilterViewModel: FilteringViewModel {
    
    var vehicleList: [VehicleCellModel]
    
    init(vehicleList: [VehicleCellModel]) {
        self.vehicleList = vehicleList
    }
}
