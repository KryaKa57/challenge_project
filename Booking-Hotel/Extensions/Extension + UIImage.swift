//
//  Extension + UIImage.swift
//  Booking-Hotel
//
//  Created by Alisher on 16.01.2024.
//

import Foundation
import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
        self.draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
