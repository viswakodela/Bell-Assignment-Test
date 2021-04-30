//
//  VehicleTableViewCell.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    private var bottomLabelBottomConstraint: NSLayoutConstraint?
    
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
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var childStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [vehicleMake, vehiclePrice])
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
        vehicleImageView.heightAnchor.constraint(equalTo: sv.heightAnchor, multiplier: 0.8).isActive = true
        sv.backgroundColor = .lightGray
        sv.alignment = .center
        return sv
    }()
    
    let bottomLabel: UILabel = {
        let label = BaseLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
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
        backgroundColor = .white
        addSubview(mainStackView)
        addSubview(separatorView)
        addSubview(bottomLabel)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 120),
            
            bottomLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 4),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 4),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
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
        UIView.transition(with: bottomLabel,
                          duration: 0.25,
                          options: .transitionCrossDissolve) {
            self.bottomLabel.attributedText = viewModel.isExpanded ? viewModel.prosConsString : NSAttributedString()
            self.layoutIfNeeded()
        } completion: { _ in }

    }
}
