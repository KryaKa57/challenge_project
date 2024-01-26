//
//  FinalCoordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//

import Foundation
import UIKit


final class FinalCoordinator: ChildCoordinator { // Координатор "Финал"
    var parent: HotelCoordinator? // Родительский координатор
    var navigationController: UINavigationController // Навигационный контроллер для переходов
    
    init(navigationController: UINavigationController) { // Инициализация
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) { // Метод с протокола для старта координатора
        let finalViewController = FinalViewController()
        finalViewController.coordinator = self
        navigationController.pushViewController(finalViewController, animated: animated)
    }
    
    func coordinatorDidFinish() { // Метод с протокола при отключении координатора
        parent?.childDidFinish(self) // вызывается родитель для удаления со списка детей
    }
}
