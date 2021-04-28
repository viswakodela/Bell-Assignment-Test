//
//  TableViewCellProtocol.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

protocol TableViewCellProtocol {
    func update(with viewModel: TableViewCellModelProtocol)
}

protocol TableViewCellModelProtocol {
    var accessoryType: UITableViewCell.AccessoryType { get }
}

extension TableViewCellModelProtocol {
    var accessoryType: UITableViewCell.AccessoryType {
        return .disclosureIndicator
    }
}
