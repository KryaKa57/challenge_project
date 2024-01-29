//
//  CustomStackView.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

class CustomStackView: UIStackView { // Класс с кастомным стаком

    let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // Отступы

    required init() {
        super.init(frame: .zero)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }

    private func setup() { // Настройки стака
        spacing = 16
        alignment = .leading
        axis = .vertical
        backgroundColor = .white
        layoutMargins = padding
        isLayoutMarginsRelativeArrangement = true
        layer.cornerRadius = 12
    }
}
