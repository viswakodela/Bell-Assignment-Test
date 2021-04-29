//
//  VehicleFilteringHeaderView.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-29.
//

import UIKit

class VehicleFilteringHeaderView: UITableViewHeaderFooterView {
    
    // MARK:- Layout Objects
    let vehicleImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: BaseLabel = {
        let label = BaseLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    let subtitleLabel: BaseLabel = {
        let label = BaseLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    lazy var labelsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 6
        sv.alignment = .leading
        return sv
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(vehicleImageView)
        vehicleImageView.addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            vehicleImageView.topAnchor.constraint(equalTo: topAnchor),
            vehicleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vehicleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vehicleImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            
            labelsStackView.bottomAnchor.constraint(equalTo: vehicleImageView.bottomAnchor, constant: -20),
            labelsStackView.leadingAnchor.constraint(equalTo: vehicleImageView.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: vehicleImageView.trailingAnchor, constant: -16),
            labelsStackView.heightAnchor.constraint(lessThanOrEqualTo: vehicleImageView.heightAnchor, multiplier: 0.5)
        ])
    }
}

extension VehicleFilteringHeaderView: TableViewCellProtocol {
    func update(with viewModel: TableViewCellModelProtocol) {
        if let viewModel = viewModel as? VehicleHeaderViewModel {
            vehicleImageView.image = viewModel.vehicleImage
            titleLabel.text = viewModel.titleLabel
            subtitleLabel.text = viewModel.subtitleLabel
        }
    }
}
