//
//  MainViewController.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

class MainViewController: BaseViewController {
    
    // MARK:- Properties
    private let viewModel: MainVM
    
    // MARK:- init
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCarList()
    }
    
    // MARK:- Private Methods
    private func fetchCarList() {
        viewModel.fetchCarListData()
    }
    
}
