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
        let placeholderColor = Color.placeholder().getUIColor()
        let textAttributes = [NSAttributedString.Key.foregroundColor: placeholderColor,
                              NSAttributedString.Key.font: FontConstant.regular().getUIFont()]
        backgroundColor = Color.background().getUIColor()
        attributedPlaceholder = NSAttributedString(string: placholderText, attributes: textAttributes as [NSAttributedString.Key: Any])
        layer.cornerRadius = 16
        textColor = .black
        tintColor = placeholderColor
        floatingLabelActiveTextColor = placeholderColor
        floatingLabelFont = FontConstant.regular().getUIFont(size: 12)
        floatingLabelYPadding = 5
    }

}

extension UITextField {
    func colorError() {
        backgroundColor = Color.error().getUIColor()
    }
}
