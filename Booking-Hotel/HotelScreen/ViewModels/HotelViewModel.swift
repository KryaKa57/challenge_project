//
//  HotelViewModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation

protocol APIRequestDelegate { // Создание делегата
    func onSucceedRequest() // Функция при успешном выполнении запросаи
    func onFailedRequest(errorMessage: String) // Функция при неудачном запросе
}

class HotelViewModel {
    
    var hotelInformation: Hotel? // Информация об отеле
    var delegate: APIRequestDelegate? // Создание переменной делегата
    let moreInformation = [MoreInformation(title: TextConstants.moreInfoFirstTitle, imageName: TextConstants.moreInfoFirstIcon),
                           MoreInformation(title: TextConstants.moreInfoSecondTitle, imageName: TextConstants.moreInfoSecondIcon),
                           MoreInformation(title: TextConstants.moreInfoThirdTitle, imageName: TextConstants.moreInfoThirdIcon)]  // Данные для таблицы с условиями отеля
    
    func getInfo() { // Функция для получения данных об отеле
        let endpoint = Endpoint.getHotel() // Создание конечного пункта
        
        // Вызываем сетевой запрос для получения данных с конечным пунктом
        NetworkManager.request(data: nil, with: endpoint) { [weak self] (result: Result<Hotel, NetworkError>) in
            switch result {
            case .success(let res): // При успешном выполнении
                self?.hotelInformation = res // Сохранение информации об отеле
                self?.delegate?.onSucceedRequest() // Вызов делегата
            case .failure(let err): // При получении ошибки
                self?.delegate?.onFailedRequest(errorMessage: err.getErrorMessage()) // Вызов делегата
            }
        }
    }
}
