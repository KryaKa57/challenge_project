//
//  FinalCoordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//

import Foundation
import UIKit


final class FinalCoordinator: ChildCoordinator {
    var viewControllerRef: UIViewController?
    var parent: HotelCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let finalViewController = FinalViewController()
        finalViewController.coordinator = self
        navigationController.pushViewController(finalViewController, animated: animated)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
}
