//
//  Extension + UIImageView.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit
extension UIImageView {
    func loadImage(from urlString: String, defaultImage: UIImage? = nil, completion: ((Result<UIImage?, Error>) -> Void)? = nil) {
        guard let url = URL(string: urlString), urlString.count < 512 else {
            completion?(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Handle error and set default image if available
                DispatchQueue.main.async {
                    self.image = defaultImage
                }
                completion?(.failure(error))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                // Handle invalid data and set default image if available
                DispatchQueue.main.async {
                    self.image = defaultImage
                }
                completion?(.failure(NSError(domain: "Invalid Data", code: 1, userInfo: nil)))
                return
            }

            // Set the loaded image
            DispatchQueue.main.async {
                self.image = image
            }

            completion?(.success(image))
        }.resume()
    }
}
