//
//  TextConstants.swift
//  Booking-Hotel
//
//  Created by Alisher on 26.01.2024.
//

import Foundation

enum TextConstants {
    static let firstTitleText = "Отель"
    static let secondTitleText = "Бронирование"
    static let firstNextButtonText = "К выбору номера"
    static let secondNextButtonText = "Выбрать номер"
    static let thirdNextButtonText = "К выбору номера"
    static let moreInfoFirstTitle = "Удобства"
    static let moreInfoSecondTitle = "Что включено"
    static let moreInfoThirdTitle = "Что не включено"
    static let phoneNumberPlaceholderText = "Номер телефона"
    static let additionalInfoText = "Эти данные никому не передаются. " +
                                    "После оплаты мы вышли чек на указанный вами номер и почту"
    static let addTouristLabelText = "Добавить туриста"
    static let emailPlaceholderText = "Почта"
    static let defaultImageText = "defaultImage"
    static let errorText = "error"
    static let additionalLabelText = "Подтверждение заказа №\(Int(arc4random_uniform(900000) + 100000)) может занять некоторое время (от 1 часа до суток). "
            + "Как только мы получим ответ от туроператора, вам на почту придет уведомление."
    static let failedRequestMessage = "Не удалось подключиться к API"

    static let aboutHotel = "Об отеле"
    static let allNecessary = "Самое необходимое"
    static let moreAboutHotel = "Подробнее о номере  "
    static let firstTouristText = "Первый турист"
    static let infoAboutTourist = "Информация о покупателе"
    static let orderPaidText = "Заказ оплачен"
    static let orderAcceptedText = "Ваш заказ принят в работу"
    static let coolText = "Супер!"

    static let starIcon = "star.fill"
    static let chevronRightIcon = "chevron.right"
    static let chevronLeftIcon = "chevron.left"
    static let chevronDownIcon = "chevron.down"
    static let chevronUpIcon = "chevron.up"
    static let moreInfoFirstIcon = "emoji-happy"
    static let moreInfoSecondIcon = "tick-square"
    static let moreInfoThirdIcon = "close-square"
    static let plusIcon = "plus"
    static let partyPopperIcon = "party-popper"
    static let exlamationmarkIcon = "exclamationmark.circle.fill"

    static let fatalErrorText = "init(coder:) has not been implemented"
    static let fatalLabelErrorText = "non-UILabel subview found!"

}
