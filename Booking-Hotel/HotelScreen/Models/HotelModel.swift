//
//  HotelModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation

struct Hotel: Codable { // Структура для получения данных с API запроса
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

struct AboutTheHotel: Codable { // Структура для получения данных с API запроса
    let description: String
    let peculiarities: [String]
}

struct MoreInformation { // Струтура для хранения данных с TableView
    let title: String
    let imageName: String
}
