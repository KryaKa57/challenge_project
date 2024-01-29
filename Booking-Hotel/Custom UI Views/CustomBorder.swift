//
//  CustomBorder.swift
//  Booking-Hotel
//
//  Created by Alisher on 26.01.2024.
//

import Foundation
import UIKit

class CustomBorderLayer: CALayer {
    // Класс для границы в виде линии
    var width: CGFloat = 0

    required init(width: CGFloat) {
        self.width = width
        super.init()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }

    private func setup() { // Настройки границы
        backgroundColor = Color.border().getUIColor().cgColor
        frame = CGRect(x: 0, y: 0, width: width, height: 1)
    }
}
