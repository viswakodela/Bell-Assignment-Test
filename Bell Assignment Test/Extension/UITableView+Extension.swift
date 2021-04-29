//
//  UITableView+Extension.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

extension UITableView {
    
    enum Constants {
        static let kDefaultCellHeight: CGFloat = 44
        static let kDefaultHeaderHeight: CGFloat = 0
    }

    func regularSetup() {
        self.estimatedRowHeight = Constants.kDefaultCellHeight
        self.rowHeight = UITableView.automaticDimension

        self.sectionHeaderHeight = UITableView.automaticDimension
        self.estimatedSectionHeaderHeight = Constants.kDefaultHeaderHeight
    }
}
