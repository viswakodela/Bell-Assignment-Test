//
//  MainViewModel.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import Combine
import UIKit

protocol MainVM {
    var cellIdentifiers: [AnyObject.Type] { get }
    func fetchCarListData()
    func updatedSnapshotForItem(at indexPath: IndexPath) -> MainVM.Snapshot?
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, VehicleCellModel>
}


class MainViewModel: MainVM {
    
    @Published
    private(set) var carItems = [VehicleCellModel]()
    var snapshot: Snapshot?
    var currentSelectedIndexPath: IndexPath?
    
    var cellIdentifiers: [AnyObject.Type] {
        [VehicleTableViewCell.self]
    }
    
    func fetchCarListData() {
        Bundle.main.carListData { (result) in
            switch result {
            case .failure:
                carItems = []
            case .success(let vehicles):
                carItems = vehicles.map { VehicleCellModel(vehicle: $0) }
            }
        }
    }
    
    func updatedSnapshotForItem(at indexPath: IndexPath) -> MainVM.Snapshot? {
        guard var snapshot = snapshot else { return nil }
        snapshot.reloadItems([carItems[indexPath.row]])
        return snapshot
    }
}
