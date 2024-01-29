//
//  Endpoint.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation

enum Endpoint {
    // Перечисления для конечных пунктов API
    case getHotel(url: String = "/v3/d144777c-a67f-4e35-867a-cacc3b827473")
    case getRooms(url: String = "/v3/8b532701-709e-4194-a41c-1a903af00195")
    case getBookingInfo(url: String = "/v3/63866c74-d593-432c-af8e-f279d1a8d2ff")

    var request: URLRequest? {
        // Вычисляемое свойство для получения URLRequest
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.addValues(for: self)
        return request
    }

    var url: URL? {
        // Вычисляемое свойство для получения URL
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.port = nil
        components.path = self.path
        return components.url
    }

    private var path: String {
        // Вычисляемое свойство для получения пути
        switch self {
        case .getHotel(let url), .getRooms(let url), .getBookingInfo(let url):
            return url
        }
    }

    private var httpMethod: String {
        // Вычисляемое свойство для получения HTTP метода
        switch self {
        case .getHotel, .getRooms, .getBookingInfo:
            return HTTP.Method.get.rawValue
        }
    }
}

extension URLRequest {
    // Расширение для добавления значений в URLRequest
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .getHotel, .getRooms, .getBookingInfo:
            let cookies =  URLSession.shared.configuration.httpCookieStorage?.cookies ?? [HTTPCookie()]
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.accept.rawValue)
            self.setValue(cookies.first?.value, forHTTPHeaderField: HTTP.Headers.Key.csrfToken.rawValue)
        }
    }
}
