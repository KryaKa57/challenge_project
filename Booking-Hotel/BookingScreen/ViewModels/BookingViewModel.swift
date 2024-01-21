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
    
    func format(phone: String) -> String {
        var mask = "(***) ***-**-**"
        var result = "+7 "
        
        let charactersToRemove: Set<Character> = ["(", ")", "*", "-", " "]
        var newString = phone.count > 2 ? String(String(phone.dropFirst(2)).filter{!charactersToRemove.contains($0)}) : phone

        if (phone.count == mask.count + 2) {
            newString = String(newString.dropLast())
        }
        
        let numbers = newString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "*" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        mask = String(mask.dropFirst(result.count - 3))
        return result + mask
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func getPriceTexts(_ row: Int) -> (String, String) {
        let leftText = bookingPriceBlocks[row].title
        let rightText = bookingPriceBlocks[row].description
        return (leftText, rightText)
    }
    
    func getInfoTexts(_ row: Int) -> (String, String) {
        let leftText = bookingInfoBlocks[row].title
        let rightText = bookingInfoBlocks[row].description
        return (leftText, rightText)
    }
}
