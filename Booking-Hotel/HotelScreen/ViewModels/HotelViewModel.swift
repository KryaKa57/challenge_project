//
//  HotelViewModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation

protocol APIRequestDelegate {
    func onSucceedRequest()
}

class HotelViewModel {
    
    var hotelInformation: Hotel?
    var delegate: APIRequestDelegate?
    let moreInformation = [MoreInformation(title: TextConstants.moreInfoFirstTitle, imageName: TextConstants.moreInfoFirstIcon),
                           MoreInformation(title: TextConstants.moreInfoSecondTitle, imageName: TextConstants.moreInfoSecondIcon),
                           MoreInformation(title: TextConstants.moreInfoThirdTitle, imageName: TextConstants.moreInfoThirdIcon)]
    
    func getInfo() {
        let endpoint = Endpoint.getHotel()
        NetworkManager.request(data: nil, with: endpoint) { [weak self] (result: Result<Hotel, NetworkError>) in
            switch result {
            case .success(let res):
                self?.hotelInformation = res
                self?.delegate?.onSucceedRequest()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
