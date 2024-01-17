//
//  Extension + FloatingTextField.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import JVFloatLabeledTextField

extension JVFloatLabeledTextField {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15))
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15))
    }
    
    func setup(placholderText: String) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x767676),
                              NSAttributedString.Key.font: Constant.defaultFont]
        self.backgroundColor = UIColor(rgb: 0xF6F6F9)
        self.attributedPlaceholder = NSAttributedString(string: placholderText, attributes: textAttributes)
        self.layer.cornerRadius = 16
        self.textColor = .black
        self.tintColor = UIColor(rgb: 0x767676)
        self.floatingLabelActiveTextColor = UIColor(rgb: 0xA9ABB7)
        self.floatingLabelFont = UIFont(name: "SFProDisplay-Regular", size: 12)
        self.floatingLabelYPadding = 5
    }
}
