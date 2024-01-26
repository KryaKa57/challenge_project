//
//  HotelCoordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//


import Foundation
import UIKit

final class HotelCoordinator: NSObject, Coordinator, ParentCoordinator { // Координатор "Отеля"
    // Координатор является родителем всех последующих коордиантором
    
    var childCoordinators = [Coordinator]() // Список "детей"-координаторов
    var navigationController: UINavigationController // Навигационный контроллер для переходов
    
    lazy var hotelViewModel: HotelViewModel! = { // ViewModel для экрана "Отеля"
        let viewModel = HotelViewModel()
        viewModel.getInfo()
        return viewModel
    }()
    
    init(navigationController: UINavigationController) { // Инициализация координатора
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) { // Метод с протокола для старта координатора
        let hotelViewController = HotelViewController(viewModel: hotelViewModel)
        hotelViewController.coordinator = self
        navigationController.pushViewController(hotelViewController, animated: animated)
    }
    
    func toRoomScreen() { // Метод для перехода к экрану "Комната"
        roomScreen(navigationController: navigationController, animated: true, roomName: hotelViewModel.hotelInformation?.name)
    }
}
