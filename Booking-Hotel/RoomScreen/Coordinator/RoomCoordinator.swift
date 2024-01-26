//
//  RoomCoordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//

import Foundation
import UIKit

final class RoomCoordinator: ChildCoordinator {  // Координатор "Комнаты"
    var parent: HotelCoordinator? // Родительский координатор
    var navigationController: UINavigationController // Навигационный контроллер для переходов
    
    private var text: String? // Текст при получении с предыдущего координатора
    
    lazy var roomViewModel: RoomViewModel! = {
        let viewModel = RoomViewModel()
        viewModel.getInfo()
        return viewModel
    }()
    
    init(text: String?, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.text = text
    }
    
    func start(animated: Bool) { // Метод с протокола для старта координатора
        let roomViewController = RoomViewController(viewModel: roomViewModel)
        roomViewModel.title = text
        roomViewController.coordinator = self
        navigationController.pushViewController(roomViewController, animated: animated)
    }
    
    func coordinatorDidFinish() { // Метод с протокола при отключении координатора
        parent?.childDidFinish(self) // вызывается родитель для удаления со списка детей
    }
    
    func toBookingScreen() {  // Метод для перехода к экрану "Бронирование"
        parent?.bookingScreen(navigationController: navigationController, animated: true)
    }
}
