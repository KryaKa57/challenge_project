//
//  FontConstant.swift
//  Booking-Hotel
//
//  Created by Alisher on 26.01.2024.
//

import Foundation
import UIKit

enum FontConstant {
    case regular(name: String = "SFProDisplay-Regular")
    case bold(name: String = "SFProDisplay-Bold")
    case medium(name: String = "SFProDisplay-Medium")

    func getUIFont(size: CGFloat = 16) -> UIFont {
        switch self {
        case .regular(let name), .bold(let name), .medium(let name):
            return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        }

    }
}
