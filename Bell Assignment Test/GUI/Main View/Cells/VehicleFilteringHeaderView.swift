//
//  VehicleFilteringHeaderView.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-29.
//

import UIKit

class VehicleFilteringHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VehicleFilteringHeaderView: TableViewCellProtocol {
    func update(with viewModel: TableViewCellModelProtocol) {
        
    }
}
