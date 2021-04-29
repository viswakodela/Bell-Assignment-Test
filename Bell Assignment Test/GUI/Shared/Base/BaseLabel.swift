//
//  BaseLabel.swift
//  Bell Assignment Test
//
//  Created by Viswa Kodela on 2021-04-28.
//

import UIKit

class BaseLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        defaultSetup()
    }

    override func drawText(in rect: CGRect) {
        if let contentInset = contentInset {
            super.drawText(in: rect.inset(by: contentInset))
        } else {
            super.drawText(in: rect)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var shouldUseDefaultTextColor: Bool = true

    var contentInset: UIEdgeInsets? = nil {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    func didUpdateFont(_ font: UIFont) {
        self.font = font
    }

    func defaultSetup() {

        if shouldUseDefaultTextColor {
            self.textColor = UIColor.label
        }
        self.adjustsFontForContentSizeCategory = true
        self.layer.masksToBounds = true
    }
}
