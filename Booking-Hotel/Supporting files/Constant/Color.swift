//
//  Color.swift
//  Booking-Hotel
//
//  Created by Alisher on 26.01.2024.
//

import Foundation
import UIKit

enum Color {
    case blue(color: Int = 0x0D72FF)
    case yellow(color: Int = 0xFFA800)
    case gray(color: Int = 0x828796)
    case lightGray(color: Int = 0xFBFBFC)
    case brightYellow(color: Int = 0xFFC700, opacity: Double = 0.2)

    case border(color: Int = 0xE8E9EC)
    case background(color: Int = 0xF6F6F9)
    case placeholder(color: Int = 0xA9ABB7)

    case error(color: Int = 0xEB5757, opacity: Double = 0.15)

    func getUIColor(opacity: Double = 1) -> UIColor {
        switch self {
        case .blue(let color), .background(let color), .yellow(let color), .border(let color), .gray(let color), .lightGray(let color), .placeholder(let color):
            return UIColor(rgb: color, alpha: opacity)

        case .brightYellow(let color, let opacity), .error(let color, let opacity):
            return UIColor(rgb: color, alpha: opacity)
        }

    }
}
