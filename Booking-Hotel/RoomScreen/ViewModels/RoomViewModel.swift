//
//  RoomViewModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation

class RoomViewModel {
    var title: String? // Заглавие контроллера
    var roomsInformation: [Room]? // Информация о типах комнат
    var delegate: APIRequestDelegate? // // Создание переменной делегата
    
    func getInfo() { // Функция для получения данных об отеле
        let endpoint = Endpoint.getRooms()
        NetworkManager.request(data: nil, with: endpoint) { [weak self] (result: Result<RoomData, NetworkError>) in
            switch result {
            case .success(let res):
                self?.roomsInformation = res.rooms
                self?.delegate?.onSucceedRequest()
            case .failure(let err):
                self?.delegate?.onFailedRequest(errorMessage: err.getErrorMessage())
                print(err.localizedDescription)
            }
        }
    }
}
