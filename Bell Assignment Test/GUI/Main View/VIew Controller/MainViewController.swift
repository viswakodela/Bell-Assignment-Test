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
    
    private var headerView: VehicleFilteringHeaderView!
    
    // MARK:- Properties
    private var subscription = Set<AnyCancellable>()
    private let viewModel: MainViewModel
    private var dataSource: UITableViewDiffableDataSource<Section, VehicleCellModel>!
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, VehicleCellModel>
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK:- init
    init(viewModel: MainVM) {
        self.viewModel = viewModel as! MainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        headerView = VehicleFilteringHeaderView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: view.frame.width,
                                                                    height: 400))
        tableView.tableHeaderView = headerView
        headerView.makeModelFilterView.makeTextField.addTarget(self, action: #selector(vehicleMakeTextChange), for: .editingChanged)
        headerView.makeModelFilterView.modelTextField.addTarget(self, action: #selector(vehicleModelTextChange), for: .editingChanged)
        headerView.update(with: viewModel.vehicleHeaderModel)
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
        
        viewModel.combinedPublisher
            .sink { [unowned self] filteredVehicles in
                self.applySnapshot()
            }
            .store(in: &subscription)
    }
    
    private func fetchCarList() {
        viewModel.fetchCarListData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                // show error
                break
            case .success:
                DispatchQueue.main.async { [self] in
                    let firstIndexPath = IndexPath(row: 0, section: 0)
                    self.viewModel.currentSelectedIndexPath = firstIndexPath
                    let vm = self.dataSource.itemIdentifier(for: firstIndexPath)
                    vm?.isExpanded = true
                    self.applySnapshot()
                }
            }
        }
    }
    
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.vehicles])
        snapshot.appendItems(viewModel.carItems)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applySnapshot(for indexPath: IndexPath) {
        var snapshot = dataSource.snapshot()
        if !viewModel.carItems.isEmpty {
            snapshot.reloadItems([viewModel.carItems[indexPath.row]])
            dataSource.apply(snapshot)
        }
    }
    
    @objc
    func vehicleMakeTextChange(sender: AnyObject) {
        viewModel.vehicleMakeText = (sender as? UITextField)?.text ?? ""
    }
    
    @objc
    func vehicleModelTextChange(sender: AnyObject) {
        viewModel.vehicleModelText = (sender as? UITextField)?.text ?? ""
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vehicleModel = dataSource.itemIdentifier(for: indexPath)
        
//        if let oldIndexPath = viewModel.currentSelectedIndexPath,
//           oldIndexPath != indexPath {
//            let oldViewModel = dataSource.itemIdentifier(for: oldIndexPath)
//            oldViewModel?.isExpanded = false
//            
//            applySnapshot(for: oldIndexPath)
//        }
        
        viewModel.currentSelectedIndexPath = indexPath
        vehicleModel?.isExpanded.toggle()
        applySnapshot(for: indexPath)
    }
}
