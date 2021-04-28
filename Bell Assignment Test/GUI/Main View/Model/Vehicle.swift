//
//  Vehicle.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import Foundation
import UIKit

struct Vehicle: Decodable {
    let customerPrice: Int
    let make: String
    let marketPrice: Int
    let model: String
    let prosList: [String]
    let consList: [String]
    let rating: Int
    
    var carImage: UIImage {
        let imageName = make.replacingOccurrences(of: " ", with: "_") + "_" + model.replacingOccurrences(of: " ", with: "_")
        return UIImage(named: imageName) ?? UIImage()
    }
}
