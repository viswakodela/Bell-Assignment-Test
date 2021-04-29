//
//  VehicleCellModel.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit
import Combine

protocol VehicleCellModelProtocol: TableViewCellModelProtocol {
    var isExpanded: Bool { get set }
    var prosList: [String] { get }
    var consList: [String] { get }
    var vehicleImage: UIImage { get }
    var title: String { get }
    var priceLabel: String { get }
    var rating: Int { get }
    var backgroundColor: UIColor { get }
}

extension VehicleCellModelProtocol {
    var backgroundColor: UIColor {
        return UIColor.lightGray
    }
    
    var isBottomLabelHidden: Bool {
        return !isExpanded
    }
    
    var prosConsString: NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let prosHeading = NSAttributedString(string: "Pros:\n",
                                             attributes: [.foregroundColor : UIColor.primaryTextColor,
                                                          .font : UIFont.systemFont(ofSize: 17, weight: .bold)])
        attributedString.append(prosHeading)
        
        let dot = NSAttributedString(string: "• ",
                                     attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                                                  .foregroundColor : UIColor.navBarTintColor])
        
        prosList.forEach { (pro) in
            if !pro.isEmpty {
                let prosList = NSAttributedString(string: "\(pro)\n")
                attributedString.append(dot)
                attributedString.append(prosList)
            }
        }
        
        let consHeading = NSAttributedString(string: "\nCons:\n",
                                             attributes: [.foregroundColor : UIColor.primaryTextColor,
                                                          .font : UIFont.systemFont(ofSize: 17, weight: .bold)])
        attributedString.append(consHeading)
        
        consList.forEach { (con) in
            if !con.isEmpty {
                let cosnList = NSAttributedString(string: "\(con)\n")
                attributedString.append(dot)
                attributedString.append(cosnList)
            }
        }
        
        return attributedString
    }
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
        "Price: \(vehicle.customerPrice.roundedWithAbbreviations)"
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
