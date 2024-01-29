//
//  HTTP.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation

enum HTTP {
    // Перечисления для представления HTTP

    enum Method: String {
        // Перечисление для HTTP-методов
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
    }

    enum Headers {
        // Перечисление для HTTP заголовков

        enum Key: String {
            // Перечисление для ключей заголовков
            case contentType = "Content-Type"
            case accept = "Accept"
            case csrfToken = "X-CSRFtoken"
            case auth = "Authorization"
        }

        enum Value: String {
            // Перечисление для значений заголовков
            case applicationJson = "application/json"
        }
    }
}
