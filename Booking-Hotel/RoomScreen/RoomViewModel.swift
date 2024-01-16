//
//  RoomViewModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation

class RoomViewModel {
    var title: String?
    var roomsInformation: [Room]?
    var delegate: APIRequestDelegate?
    
    func getInfo() {
        let endpoint = Endpoint.getRooms()
        NetworkManager.request(data: nil, with: endpoint) { [weak self] (result: Result<RoomData, NetworkError>) in
            switch result {
            case .success(let res):
                self?.roomsInformation = res.rooms
                self?.delegate?.onSucceedRequest()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
