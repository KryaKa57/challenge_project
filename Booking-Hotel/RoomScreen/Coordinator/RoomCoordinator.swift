//
//  RoomCoordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//

import Foundation
import UIKit

final class RoomCoordinator: ChildCoordinator {
    var viewControllerRef: UIViewController?
    var parent: HotelCoordinator?
    var navigationController: UINavigationController
    
    private var text: String?
    
    lazy var roomViewModel: RoomViewModel! = {
        let viewModel = RoomViewModel()
        viewModel.getInfo()
        return viewModel
    }()
    
    init(text: String?, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.text = text
    }
    
    func start(animated: Bool) {
        let roomViewController = RoomViewController(viewModel: roomViewModel)
        roomViewModel.title = text
        roomViewController.coordinator = self
        navigationController.pushViewController(roomViewController, animated: animated)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
    func toBookingScreen() {
        parent?.bookingScreen(navigationController: navigationController, animated: true)
    }
}
