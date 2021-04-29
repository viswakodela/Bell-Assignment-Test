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
        let sv = UIStackView(arrangedSubviews: [UIView(), vehicleImageView, childStackView, UIView()])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        vehicleImageView.widthAnchor.constraint(equalTo: sv.widthAnchor, multiplier: 0.3).isActive = true
        vehicleImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        sv.backgroundColor = .lightGray
        sv.alignment = .center
        return sv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separatorColor
        return view
    }()
    
    // MARK:- init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Private Methods
    private func setupLayout() {
        addSubview(mainStackView)
        addSubview(separatorView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 4),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
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
