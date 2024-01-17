//
//  CustomStackView.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

class CustomStackView: UIStackView {
    
    let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    required init() {
        super.init(frame: .zero)
        setup()
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setup() {
        spacing = 16
        alignment = .leading
        axis = .vertical
        backgroundColor = .white
        layoutMargins = padding
        isLayoutMarginsRelativeArrangement = true
        layer.cornerRadius = 12
    }
}
