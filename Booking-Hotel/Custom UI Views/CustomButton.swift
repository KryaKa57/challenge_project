//
//  CustomButton.swift
//  Booking-Hotel
//
//  Created by Alisher on 16.01.2024.
//


import Foundation
import UIKit


class CustomButton: UIButton {
    
    let padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 5)
    
    var textValue: String
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = UIColor(rgb: 0x0D72FF)
            } else {
                self.backgroundColor = UIColor(rgb: 0x0D72FF, alpha: 0.1)
            }
        }
    }
    
    required init(textValue: String) {
        self.textValue = textValue
        super.init(frame: .zero)
        setup()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setup() {
        self.setTitle(textValue, for: .normal)
        self.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)!
        self.backgroundColor = UIColor(rgb: 0x0D72FF)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 12
    }
}
