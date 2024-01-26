//
//  BookingCoordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//

import Foundation
import UIKit

final class BookingCoordinator: ChildCoordinator { // Координатор "Бронирование"
    var parent: HotelCoordinator? // Родительский координатор
    var navigationController: UINavigationController // Навигационный контроллер для переходов
    
    lazy var bookingViewModel: BookingViewModel! = {
        let viewModel = BookingViewModel()
        viewModel.getInfo()
        return viewModel
    }()
    
    init(navigationController: UINavigationController) { // Инициализация
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {  // Метод с протокола для старта координатора
        let bookingViewController = BookingViewController(viewModel: bookingViewModel)
        bookingViewController.coordinator = self
        navigationController.pushViewController(bookingViewController, animated: animated)
    }
    
    func coordinatorDidFinish() { // Метод с протокола при отключении координатора
        parent?.childDidFinish(self) // вызывается родитель для удаления со списка детей
    }
    
    func toFinalScreen() { // Метод для перехода к финального экрана
        parent?.finalScreen(navigationController: navigationController, animated: true)
    }
}
