//
//  NetworkManager.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknown(String = "An unknown error occured.")
}

class NetworkManager {
    static func request<T: Decodable> (data: Data?,
                                        with endpoint: Endpoint,
                                        completition: @escaping (Result<T, NetworkError>)->Void) {
        var request = endpoint.request!
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) {data, resp, error in
            if let error = error {
                completition(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode < 200 && resp.statusCode >= 300 {
                completition(.failure(.invalidResponse))
                return
            }
            
            do {
                if try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) is [String: Any] {
                } else {
                    throw URLError(.badServerResponse)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let tokenKey = try decoder.decode(T.self, from: data)
                    completition(.success(tokenKey))
                } catch {
                    completition(.failure(.invalidData))
                }
            } else {
                completition(.failure(.unknown()))
            }
        }.resume()
    }
}
