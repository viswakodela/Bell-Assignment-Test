//
//  VehicleTableViewCell.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    // MARK:- Layout Objects
    let vehicleImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        return iv
    }()
    
    let vehicleMake: BaseLabel = {
        let label = BaseLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryTextColor
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let vehiclePrice: BaseLabel = {
        let label = BaseLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryTextColor
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var childStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [vehicleMake, vehiclePrice, UIView()])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 6
        return sv
    }()
    
    lazy var mainStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [vehicleImageView, childStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        vehicleImageView.widthAnchor.constraint(equalTo: sv.widthAnchor, multiplier: 0.3).isActive = true
        vehicleImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return sv
    }()
    
    // MARK:- init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Private Methods
    private func setupLayout() {
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK:- TableViewCellProtocol
extension VehicleTableViewCell: TableViewCellProtocol {
    func update(with viewModel: TableViewCellModelProtocol) {
        guard let viewModel = viewModel as? VehicleCellModel else { return }
        vehicleImageView.image = viewModel.vehicleImage
        vehicleMake.text = viewModel.title
        vehiclePrice.text = viewModel.priceLabel
    }
}
