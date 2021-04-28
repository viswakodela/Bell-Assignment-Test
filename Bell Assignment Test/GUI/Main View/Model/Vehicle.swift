//
//  Vehicle.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import Foundation

struct Vehicle: Decodable {
    let customerPrice: Int
    let make: String
    let marketPrice: Int
    let model: String
    let prosList: [String]
    let consList: [String]
    let rating: Int
}
