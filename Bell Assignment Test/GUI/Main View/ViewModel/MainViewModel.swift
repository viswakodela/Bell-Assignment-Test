//
//  MainViewModel.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import Combine
import UIKit

protocol MainVM {
    var snapshotPublisher: AnyPublisher<NSDiffableDataSourceSnapshot<Section, VehicleCellModel>, Never> { get }
    var cellIdentifiers: [AnyObject.Type] { get }
    func fetchCarListData()
}


class MainViewModel: MainVM {
    
    @Published
    private var carItems = [Vehicle]()
    var cellIdentifiers: [AnyObject.Type] {
        [VehicleTableViewCell.self]
    }
    
    func fetchCarListData() {
        Bundle.main.carListData { (result) in
            switch result {
            case .failure:
                carItems = []
            case .success(let vehicles):
                carItems = vehicles
            }
        }
    }
    
    var snapshotPublisher: AnyPublisher<NSDiffableDataSourceSnapshot<Section, VehicleCellModel>, Never> {
        $carItems
            .receive(on: DispatchQueue.main)
            .map { results in
                var snapshot = NSDiffableDataSourceSnapshot<Section, VehicleCellModel>()
                snapshot.appendSections([.vehicles])
                snapshot.appendItems(results.map({ (vehile) in
                    return VehicleCellModel(vehicle: vehile)
                }))
                return snapshot
            }
            .eraseToAnyPublisher()
    }
}
