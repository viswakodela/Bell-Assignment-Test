//
//  MainViewController.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit
import Combine

class MainViewController: BaseViewController {
    
    // MARK:- Layout Objects
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.separatorStyle = .none
        return tv
    }()
    
    // MARK:- Properties
    private let viewModel: MainVM
    private var diffableDatasource: UITableViewDiffableDataSource<Section, VehicleCellModel>!
    private var subscriptions = Set<AnyCancellable>()
    
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
        setupTableView()
        //tableView.regularSetup()
        configureTableView()
        addSubscriptions()
        fetchCarList()
        tableView.tableFooterView = UIView()
    }
    
    // MARK:- Private Methods
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        viewModel.cellIdentifiers.forEach { (cellId) in
            tableView.register(cellId, forCellReuseIdentifier: "\(cellId)")
        }
        diffableDatasource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tv, indexPath, result) -> UITableViewCell? in
            let cell = self.tableView.dequeueReusableCell(withIdentifier: result.identifier)
            (cell as? TableViewCellProtocol)?.update(with: result)
            return cell
        })
    }
    
    private func addSubscriptions() {
        viewModel.snapshotPublisher
            .sink { [unowned self] (snapshot) in
                self.diffableDatasource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &subscriptions)
    }
    
    private func fetchCarList() {
        viewModel.fetchCarListData()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
