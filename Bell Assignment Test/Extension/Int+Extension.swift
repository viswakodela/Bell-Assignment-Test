//
//  Int+Extension.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-29.
//


import Foundation

extension Int {
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    
    var formattedPrice: String {
        "\(Int.numberFormatter.string(from: NSNumber(value: self)) ?? String(self))"
    }
    
    // reference https://stackoverflow.com/questions/36376897/swift-2-0-format-1000s-into-a-friendly-ks
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\((round(million*10)/10).clean)M"
        }
        else if thousand >= 1.0 {
            return "\((round(thousand*10)/10).clean)K"
        }
        else {
            return "\(self)"
        }
    }
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
