//
//  VehicleHeaderViewModel.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-29.
//

import UIKit

protocol VehicleViewModelProtocol: TableViewCellModelProtocol {
    var vehicleImage: UIImage { get }
    var titleLabel: String { get }
    var subtitleLabel: String { get  }
}

extension VehicleViewModelProtocol {
    var vehicleImage: UIImage {
        return UIImage(named: "Tacoma")!
    }
    
    var titleLabel: String {
        return "Tacoma 2021"
    }
    
    var subtitleLabel: String {
        return "Get your's now"
    }
}

class VehicleHeaderViewModel: VehicleViewModelProtocol {

    let vehicles: [VehicleCellModel]
    lazy var filterViewModel = VehicleFilterViewModel(vehicleList: vehicles)
    
    init(vehicles: [VehicleCellModel]) {
        self.vehicles = vehicles
    }
}
