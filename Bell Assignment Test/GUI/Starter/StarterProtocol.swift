//
//  StarterProtocol.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

protocol StarterProtocol {
    static func start()
}

class NavigationBarStarter: StarterProtocol {
    static func start() {
        UINavigationBar.appearance().barTintColor = UIColor.navBarTintColor
        UINavigationBar.appearance().tintColor = .white
    }
}
