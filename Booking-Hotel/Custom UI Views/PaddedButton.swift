//
//  PaddedButton.swift
//  Booking-Hotel
//
//  Created by Alisher on 25.01.2024.
//

import Foundation
import UIKit

class PaddedButton: UIButton { // Класс кнопки с отступами
    var padding: CGSize = CGSize(width: 20, height: 10) // Размер внутренних отступов
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            // Увеличиваем размер кнопки (+ отступ)
            return CGSize(width: baseSize.width + padding.width,
                          height: baseSize.height + padding.height)
        }
    }

    required init(padding: CGSize) {
        self.padding = padding
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
}
