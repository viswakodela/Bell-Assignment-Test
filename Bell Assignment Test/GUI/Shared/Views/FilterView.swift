//
//  FilterView.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-30.
//

import UIKit

class FilterView: UIView {
    
    var filterViewModel: FilteringViewModel?
    
    // MARK:- Layout Objects
    let makeTextField: UITextField = {
        let tf = BellTextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Any Make"
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 8
        tf.clipsToBounds = true
        return tf
    }()
    
    let modelTextField: UITextField = {
        let tf = BellTextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Any Model"
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 8
        tf.clipsToBounds = true
        return tf
    }()
    
    let filterLabel: UILabel = {
        let label = BaseLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filter"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var tfStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [makeTextField, modelTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .leading
        sv.distribution = .fillEqually
        makeTextField.widthAnchor.constraint(equalTo: sv.widthAnchor).isActive = true
        modelTextField.widthAnchor.constraint(equalTo: makeTextField.widthAnchor).isActive = true
        return sv
    }()
    
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Private Methods
    private func setupLayout() {
        backgroundColor = UIColor.darkGray
        
        addSubview(filterLabel)
        addSubview(tfStackView)
        
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: topAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            filterLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterLabel.heightAnchor.constraint(equalToConstant: 44),
            
            tfStackView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 2),
            tfStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tfStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tfStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
