//
//  StarterFactory.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

class StarterFactory {
    func run() {
        allStarters.forEach { $0.start() }
    }

    private let allStarters: [StarterProtocol.Type] = [NavigationBarStarter.self]
}
