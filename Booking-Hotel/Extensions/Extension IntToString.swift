//
//  Extension IntToString.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation

extension Int {
    func getPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        guard let formattedString = numberFormatter.string(from: NSNumber(value: self)) else { return "" }

        return formattedString + " ₽"
    }
    
    func toString() -> String {
        let russianNumerals = ["", "Первый", "Второй", "Третий", "Четвёртый", "Пятый"]

        if self < russianNumerals.count {
            return russianNumerals[self]
        } else {
            return "\(self)-й"
        }
    }
}
