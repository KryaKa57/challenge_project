//
//  CustomTextField.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    var textValue: String
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.black.cgColor
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    required init(textValue: String, isHidden: Bool = false) {
        CustomTextField.appearance().tintColor = .black
        self.textValue = textValue
        super.init(frame: .zero)
        setup()
    }
    
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setup() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x767676),
                              NSAttributedString.Key.font: Constant.defaultFont]
        self.backgroundColor = UIColor(rgb: 0xF8F8F8)
        self.attributedPlaceholder = NSAttributedString(string: textValue, attributes: textAttributes)
        self.layer.cornerRadius = 16
        self.textColor = .black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        for view in subviews {
            if let button = view as? UIButton {
                button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = UIColor(rgb: 0x767676)
            }
        }
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -20, dy: 0)
    }
    
}
