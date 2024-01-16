//
//  HTTP.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation

enum HTTP {
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum Headers {
        enum Key: String {
            case contentType = "Content-Type"
            case accept = "Accept"
            case csrfToken = "X-CSRFtoken"
            case auth = "Authorization"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}

