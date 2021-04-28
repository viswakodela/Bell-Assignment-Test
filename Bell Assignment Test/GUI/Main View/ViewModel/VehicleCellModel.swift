//
//  VehicleCellModel.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

protocol VehicleCellModelProtocol: TableViewCellModelProtocol {
    var isExpanded: Bool { get set }
    var prosList: [String] { get }
    var consList: [String] { get }
    var vehicleImage: UIImage { get }
    var title: String { get }
    var priceLabel: String { get }
    var rating: Int { get }
}

class VehicleCellModel: VehicleCellModelProtocol {
    var uniqueId: UUID = UUID()
    
    var isExpanded: Bool = false
    
    var prosList: [String] {
        vehicle.prosList
    }
    
    var consList: [String] {
        vehicle.consList
    }
    
    var vehicleImage: UIImage {
        vehicle.carImage
    }
    
    var title: String {
        vehicle.make
    }
    
    var priceLabel: String {
        String(vehicle.customerPrice)
    }
    
    var rating: Int {
        vehicle.rating
    }
    
    var identifier: String {
        return String(describing: VehicleTableViewCell.self)
    }

    
    private let vehicle: Vehicle
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
}

extension VehicleCellModel: Hashable {
    static func == (lhs: VehicleCellModel, rhs: VehicleCellModel) -> Bool {
        lhs.uniqueId == rhs.uniqueId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(vehicle)
    }
}
