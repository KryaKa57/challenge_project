//
//  Extension + Subviews.swift
//  Booking-Hotel
//
//  Created by Alisher on 22.01.2024.
//

import Foundation
import UIKit

extension UIView {

    func getAllTextFields() -> [UITextField] {
        var result: [UITextField] = []

        self.subviews.forEach { firstSubview in
            firstSubview.subviews.forEach { secondSubview in
                secondSubview.subviews.forEach { thirdSubView in
                    if let textField = thirdSubView as? UITextField { result.append(textField) }
                }
            }
        }

        return result
    }
}
