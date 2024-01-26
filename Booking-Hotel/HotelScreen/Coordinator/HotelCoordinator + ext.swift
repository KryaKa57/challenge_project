//
//  HotelCoordinator + ext.swift
//  Booking-Hotel
//
//  Created by Alisher on 22.01.2024.
//

import Foundation
import UIKit

extension HotelCoordinator {
    // Дополнение к координатору для переходов в другие экраны
    
    func roomScreen(navigationController: UINavigationController, animated: Bool, roomName: String?) {
        // Создание координатора "Комната"
        let roomCoordinator = RoomCoordinator(text: roomName, navigationController: navigationController)
        roomCoordinator.parent = self
        addChild(roomCoordinator)
        roomCoordinator.start(animated: animated)
    }
    
    func bookingScreen(navigationController: UINavigationController, animated: Bool) {
        // Создание координатора "Бронирование"
        let bookingCoordinator = BookingCoordinator(navigationController: navigationController)
        bookingCoordinator.parent = self
        addChild(bookingCoordinator)
        bookingCoordinator.start(animated: animated)
    }
    
    func finalScreen(navigationController: UINavigationController, animated: Bool) {
        // Создание координатора "Финал"
        let finalCoordinator = FinalCoordinator(navigationController: navigationController)
        finalCoordinator.parent = self
        addChild(finalCoordinator)
        finalCoordinator.start(animated: animated)
    }
}
