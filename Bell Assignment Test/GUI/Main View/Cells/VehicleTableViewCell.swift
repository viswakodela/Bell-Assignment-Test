//
//  VehicleTableViewCell.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    // MARK:- init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- TableViewCellProtocol
extension VehicleTableViewCell: TableViewCellProtocol {
    func update(with viewModel: TableViewCellModelProtocol) {
        guard let viewModel = viewModel as? VehicleCellModel else { return }
//        titleLabel.text = viewModel.title + ", " + viewModel.subtitle
    }
}
