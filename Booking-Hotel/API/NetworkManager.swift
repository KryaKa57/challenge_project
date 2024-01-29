//
//  NetworkManager.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit
enum NetworkError: Error, Equatable {
    // Перечисление для сетевых ошибок
    case invalidURL
    case invalidResponse
    case invalidData
    case unknown(String = "An unknown error occured.")

    func getErrorMessage() -> String {
        // Метод для получения текстового описания ошибки
        switch self {
        case .invalidURL: return "Некорректная URL ссылка"
        case .invalidResponse: return "Неверный ответ"
        case .invalidData: return "Ошибка с форматом данных"
        default: return self.localizedDescription
        }
    }
}

class NetworkManager {
    // Класс для выполнения сетевых запросов
    static func request<T: Decodable> (data: Data?,
                                        with endpoint: Endpoint,
                                        completition: @escaping (Result<T, NetworkError>) -> Void) {
        // Метод для выполнения сетевого запроса с обработкой данных

        var request = endpoint.request!
        request.httpBody = data

        URLSession.shared.dataTask(with: request) {data, resp, error in
            // Обработка ответа сетевого запроса
            if let error = error {
                completition(.failure(.unknown(error.localizedDescription)))
                return
            }

            if let resp = resp as? HTTPURLResponse, resp.statusCode < 200 && resp.statusCode >= 300 {
                completition(.failure(.invalidResponse))
                return
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
    
    static func loadImage(from urlString: String, completion: ((Result<UIImage?, NetworkError>) -> Void)? = nil) {
        // Метод для загрузки изображения из URL ссылки

        guard let url = URL(string: urlString), urlString.count < 512 else {
            completion?(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                // Обработка ошибки и установка изображения по умолчанию, если оно доступно
                completion?(.failure(.unknown(error.localizedDescription)))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                // Обработка некорректных данных и установка изображения по умолчанию, если оно доступно
                completion?(.failure(.invalidData))
                return
            }
            // Установка загруженного изображения
            completion?(.success(image))
        }.resume()
    }
}
