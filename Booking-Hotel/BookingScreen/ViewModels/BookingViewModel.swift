//
//  BookingViewModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation

class BookingViewModel {
    var bookingInformation: Booking?
    var delegate: APIRequestDelegate?
    var numberOfTourist = 1
    
    var bookingInfoBlocks: [TableData] = []
    var bookingPriceBlocks: [TableData] = []
    
    func getInfo() {
        let endpoint = Endpoint.getBookingInfo()
        NetworkManager.request(data: nil, with: endpoint) { [weak self] (result: Result<Booking, NetworkError>) in
            switch result {
            case .success(let res):
                self?.bookingInformation = res
                self?.fillBlocks()
                self?.delegate?.onSucceedRequest()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func fillBlocks() {
        guard let info = bookingInformation else { return }
        bookingInfoBlocks.append(TableData(title: "Вылет из", description: info.departure))
        bookingInfoBlocks.append(TableData(title: "Страна, город", description: info.arrivalCountry))
        bookingInfoBlocks.append(TableData(title: "Даты", description: "\(info.tourDateStart) - \(info.tourDateStop)"))
        bookingInfoBlocks.append(TableData(title: "Кол-во ночей", description: "\(info.numberOfNights) ночей"))
        bookingInfoBlocks.append(TableData(title: "Отель", description: info.hotelName))
        bookingInfoBlocks.append(TableData(title: "Номер", description: info.room))
        bookingInfoBlocks.append(TableData(title: "Питание", description: info.nutrition))
        
        bookingPriceBlocks.append(TableData(title: "Тур", description: info.tourPrice.getPrice()))
        bookingPriceBlocks.append(TableData(title: "Топливный сбор", description: info.fuelCharge.getPrice()))
        bookingPriceBlocks.append(TableData(title: "Сервисный сбор", description: info.serviceCharge.getPrice()))
        bookingPriceBlocks.append(TableData(title: "К оплате", description: (info.serviceCharge + info.fuelCharge + info.tourPrice).getPrice()))
    }
    
}
