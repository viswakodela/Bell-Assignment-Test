//
//  Bundle+Extension.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import Foundation

extension Bundle {
    func carListData() {
        if let path = Bundle.main.path(forResource: "car_list", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print(jsonResult)
              } catch {
                   // handle error
                print(error)
              }
        }
    }
}

//Error Domain=NSCocoaErrorDomain Code=3840 "Badly formed object around character 188." UserInfo={NSDebugDescription=Badly formed object around character 188.}
