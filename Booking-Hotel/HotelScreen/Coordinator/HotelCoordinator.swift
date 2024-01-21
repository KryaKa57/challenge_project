//
//  HotelCoordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//


import Foundation
import UIKit

final class HotelCoordinator: NSObject, Coordinator, ParentCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    lazy var hotelViewModel: HotelViewModel! = {
        let viewModel = HotelViewModel()
        viewModel.getInfo()
        return viewModel
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let hotelViewController = HotelViewController(viewModel: hotelViewModel)
        hotelViewController.coordinator = self
        navigationController.pushViewController(hotelViewController, animated: animated)
    }
    
    func toRoomScreen() {
        roomScreen(navigationController: navigationController, animated: true, roomName: hotelViewModel.hotelInformation?.name)
    }
}
