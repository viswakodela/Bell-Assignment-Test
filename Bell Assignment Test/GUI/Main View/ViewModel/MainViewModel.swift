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
    func fetchCarListData(completion: (Result<(), AppError>) -> Void)
}


class MainViewModel: MainVM {
    
    private(set) var carItems = [VehicleCellModel]()
    private var nonFilteredCarItems = [VehicleCellModel]()
    var currentSelectedIndexPath: IndexPath?
    lazy var vehicleHeaderModel = VehicleHeaderViewModel(vehicles: carItems)
    
    @Published
    var vehicleMakeText: String = ""
    
    @Published
    var vehicleModelText: String = ""
    
    var combinedPublisher: AnyPublisher<[VehicleCellModel], Never> {
        return Publishers.CombineLatest($vehicleMakeText, $vehicleModelText)
            .receive(on: RunLoop.main)
            .map { [self] make, model in
                if !make.isEmpty || !model.isEmpty {
                    let filteredArray = carItems.filter { (vehicle) -> Bool in
                        vehicle.vehicleMake.lowercased().contains(make.lowercased()) || vehicle.vehicleModel.lowercased().contains(model.lowercased())
                    }
                    carItems = filteredArray
                } else {
                    carItems = nonFilteredCarItems
                }
                return carItems
            }
            .eraseToAnyPublisher()
    }
    
    var cellIdentifiers: [AnyObject.Type] {
        [VehicleTableViewCell.self]
    }
    
    func fetchCarListData(completion: (Result<Void, AppError>) -> Void) {
        Bundle.main.carListData { (result) in
            switch result {
            case .failure:
                carItems = []
                completion(.failure(AppError.serialization))
            case .success(let vehicles):
                carItems = vehicles.map { VehicleCellModel(vehicle: $0) }
                nonFilteredCarItems = carItems
                completion(.success(()))
            }
        }
    }
}
