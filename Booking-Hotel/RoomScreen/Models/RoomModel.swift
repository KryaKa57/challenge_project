//
//  RoomModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation

struct RoomData: Codable { // Структура для получения данных с API запроса
    let rooms: [Room]
}

struct Room: Codable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]
}
