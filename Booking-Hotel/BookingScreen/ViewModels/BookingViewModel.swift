//
//  BookingViewModel.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation

class BookingViewModel {
    var bookingInformation: Booking? // Информация о брони
    var delegate: APIRequestDelegate? // Создание переменной делегата
    var numberOfTourist = 1 // Количество туристов
    
    var bookingInfoBlocks: [TableData] = [] // Блок информации о брони
    var bookingPriceBlocks: [TableData] = [] // Блок информации о ценах
    
    // Получение информации о бронировании через сетевой запрос
    func getInfo() {
        // Создание конечного пункта
        let endpoint = Endpoint.getBookingInfo()
        
        // Вызываем сетевой запрос для получения данных с конечным пунктом
        NetworkManager.request(data: nil, with: endpoint) { [weak self] (result: Result<Booking, NetworkError>) in
            switch result {
            case .success(let res):
                // При успешном запросе сохраненияем полученную информацию, заполняем блоки таблиц и вызываем делегат
                self?.bookingInformation = res
                self?.fillBlocks()
                self?.delegate?.onSucceedRequest()
            case .failure(let err):
                self?.delegate?.onFailedRequest(errorMessage: err.getErrorMessage())
            }
        }
    }
    
    func fillBlocks() { // Заполнение блоков таблиц
        guard let info = bookingInformation else { return } // Проверка данных
        
        // Заполнение блока информации о брони
        bookingInfoBlocks.append(TableData(title: "Вылет из", description: info.departure))
        bookingInfoBlocks.append(TableData(title: "Страна, город", description: info.arrivalCountry))
        bookingInfoBlocks.append(TableData(title: "Даты", description: "\(info.tourDateStart) - \(info.tourDateStop)"))
        bookingInfoBlocks.append(TableData(title: "Кол-во ночей", description: "\(info.numberOfNights) ночей"))
        bookingInfoBlocks.append(TableData(title: "Отель", description: info.hotelName))
        bookingInfoBlocks.append(TableData(title: "Номер", description: info.room))
        bookingInfoBlocks.append(TableData(title: "Питание", description: info.nutrition))
        
        // Заполнение блока информации о ценах
        bookingPriceBlocks.append(TableData(title: "Тур", description: info.tourPrice.getPrice()))
        bookingPriceBlocks.append(TableData(title: "Топливный сбор", description: info.fuelCharge.getPrice()))
        bookingPriceBlocks.append(TableData(title: "Сервисный сбор", description: info.serviceCharge.getPrice()))
        bookingPriceBlocks.append(TableData(title: "К оплате", description: (info.serviceCharge + info.fuelCharge + info.tourPrice).getPrice()))
    }
    
    // Форматирование строки в номер телефона
    func format(phone: String, isFilled: Bool) -> String {
        // Форматирование под формат номера телефона
        var mask = "(***) ***-**-**" // Маска номера телефона
        var result = "+7 " // Неизменяемое начало формата
        
        let charactersToRemove: Set<Character> = ["(", ")", "*", "-", " "] // символы для удаления и создание только числового формата
        var newString = phone.count > 2 ? String(String(phone.dropFirst(2)).filter{!charactersToRemove.contains($0)}) : phone // Удаление первых двух символов "+7"

        if (phone.count == mask.count + result.count - 1) && !isFilled {
            // Если не заполнено и также символов номера телефона на один меньше чем маска, то удаляем последнее число
            newString = String(newString.dropLast())
        }
        
        // newString на этот момент - число, которое нужно отобразить
        
        let numbers = newString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression) // Повторный фильтр, если есть что-то лишнее еще
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex { // проходим по маске
            if ch == "*" { // Если звезда, то добавляем число за место звезды
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else { // в ином случае оставляем символ
                result.append(ch)
            }
        }
        
        mask = String(mask.dropFirst(result.count - 3)) // Убираем количество заполненных с маски
        return result + mask
    }
    
    // Проверка валидности email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // Латиница или число + @ + латиница или число + . + латиница минимум 2 максимум 64

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) // Если подходит по формату, то true
    }
    
    // Получение текстов для ячейки с ценой
    func getPriceTexts(_ row: Int) -> (String, String) {
        let leftText = bookingPriceBlocks[row].title
        let rightText = bookingPriceBlocks[row].description
        return (leftText, rightText)
    }
    
    // Получение текстов для ячейки с информацией о брони
    func getInfoTexts(_ row: Int) -> (String, String) {
        let leftText = bookingInfoBlocks[row].title
        let rightText = bookingInfoBlocks[row].description
        return (leftText, rightText)
    }
}
