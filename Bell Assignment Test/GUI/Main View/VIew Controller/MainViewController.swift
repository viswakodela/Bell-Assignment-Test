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
    private var subscription = Set<AnyCancellable>()
    private let viewModel: MainViewModel
    private var dataSource: UITableViewDiffableDataSource<Section, VehicleCellModel>!
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK:- init
    init(viewModel: MainVM) {
        self.viewModel = viewModel as! MainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerView: VehicleFilteringHeaderView = {
        let hv = VehicleFilteringHeaderView(frame: .zero)
        hv.translatesAutoresizingMaskIntoConstraints = false
        return hv
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableViewHeader()
        tableView.regularSetup()
        configureTableView()
        addSubscriptions()
        fetchCarList()
    }
    
    // MARK:- Private Methods
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableViewHeader() {
        let vehicleHeader = VehicleFilteringHeaderView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: view.frame.width,
                                                                    height: 300))
        tableView.tableHeaderView = vehicleHeader
        vehicleHeader.update(with: viewModel.vehicleHeaderModel)
    }
    
    private func configureTableView() {
        viewModel.cellIdentifiers.forEach { (cellId) in
            tableView.register(cellId, forCellReuseIdentifier: "\(cellId)")
        }
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tv, indexPath, result) -> UITableViewCell? in
            let cell = self.tableView.dequeueReusableCell(withIdentifier: result.identifier)
            (cell as? TableViewCellProtocol)?.update(with: result)
            return cell
        })
    }
    
    private func addSubscriptions(animatingDifferences: Bool = true) {
        viewModel.$carItems
            .sink { [unowned self] (vehicles) in
                self.viewModel.snapshot = MainVM.Snapshot()
                self.viewModel.snapshot?.appendSections([.vehicles])
                self.viewModel.snapshot?.appendItems(vehicles)
                if let snapshot = self.viewModel.snapshot {
                    let firstIndexPath = IndexPath(row: 0, section: 0)
                    viewModel.currentSelectedIndexPath = firstIndexPath
                    dataSource.apply(snapshot, animatingDifferences: animatingDifferences) {
                        let vm = dataSource.itemIdentifier(for: firstIndexPath)
                        vm?.isExpanded = true
                        applySnapshot(for: firstIndexPath)
                    }
                }
            }
            .store(in: &subscription)
    }
    
    private func fetchCarList() {
        viewModel.fetchCarListData()
    }
    
    private func applySnapshot(for indexPath: IndexPath) {
        if let snapShot = viewModel.updatedSnapshotForItem(at: indexPath) {
            dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vehicleModel = dataSource.itemIdentifier(for: indexPath)
        
        if let oldIndexPath = viewModel.currentSelectedIndexPath,
           oldIndexPath != indexPath {
            let oldViewModel = dataSource.itemIdentifier(for: oldIndexPath)
            oldViewModel?.isExpanded = false
            
            applySnapshot(for: oldIndexPath)
        }
        
        vehicleModel?.isExpanded.toggle()
        viewModel.currentSelectedIndexPath = indexPath
        applySnapshot(for: indexPath)
    }
}
