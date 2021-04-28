//
//  MainViewModel.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import Combine
import Foundation

protocol MainVM {
    func fetchCarListData()
}


class MainViewModel: MainVM {
    
    @Published private var carItems = PassthroughSubject<[Vehicle], AppError>()
    
    func fetchCarListData() {
        Bundle.main.carListData { (result) in
            switch result {
            case .failure(let error):
                carItems.send(completion: .failure(error))
            case .success(let vehicles):
                carItems.send(vehicles)
            }
        }
    }
}
