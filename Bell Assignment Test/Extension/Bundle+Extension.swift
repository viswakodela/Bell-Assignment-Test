//
//  Bundle+Extension.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import Foundation

extension Bundle {
    
    /// Helper method to parse the data from the `car_list.json` file
    func carListData(completion: (Result<[Vehicle], AppError>) -> Void) {
        if let path = Bundle.main.path(forResource: "car_list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let vehicles = try JSONDecoder().decode([Vehicle].self, from: data)
                completion(.success(vehicles))
            } catch {
                // handle error
                completion(.failure(AppError.serialization))
            }
        }
    }
}

// Provided JSON is having the following issue because of unexpected "/", so I had to remove it.
// Error Domain=NSCocoaErrorDomain Code=3840 "Badly formed object around character 188." UserInfo={NSDebugDescription=Badly formed object around character 188.}
