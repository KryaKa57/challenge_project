//
//  BookingCoordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//

import Foundation
import UIKit

final class BookingCoordinator: ChildCoordinator {
    var viewControllerRef: UIViewController?
    var parent: HotelCoordinator?
    var navigationController: UINavigationController
    
    lazy var bookingViewModel: BookingViewModel! = {
        let viewModel = BookingViewModel()
        viewModel.getInfo()
        return viewModel
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let bookingViewController = BookingViewController(viewModel: bookingViewModel)
        bookingViewController.coordinator = self
        navigationController.pushViewController(bookingViewController, animated: animated)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    func toFinalScreen() {
        parent?.finalScreen(navigationController: navigationController, animated: true)
    }
}
