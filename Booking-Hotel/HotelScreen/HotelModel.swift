//
//  HotelModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation

struct Hotel: Codable {
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel
}

// MARK: - AboutTheHotel
struct AboutTheHotel: Codable {
    let description: String
    let peculiarities: [String]
}

struct MoreInformation {
    let title: String
    let imageName: String
}
