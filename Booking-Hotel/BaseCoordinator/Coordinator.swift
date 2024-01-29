//
//  Coordinator.swift
//  Booking-Hotel
//
//  Created by Alisher on 19.01.2024.
//

import Foundation
import UIKit

// Протол для координаторов
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }

    func start(animated: Bool)

    func popViewController()
}

/*
 В расширении действие двух функции с протокола:
   - снять текущий контроллер
   - вернуться к корню навигации, сняв все контроллеры
 */
extension Coordinator {
    func popViewController() { navigationController.popViewController(animated: true) }

    func popToRootViewController() { navigationController.popToRootViewController(animated: true) }
}

// Протокол для родительского контроллера
protocol ParentCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }

    func addChild(_ child: Coordinator)

    func childDidFinish(_ child: Coordinator)
}

/*
 Родительский контроллер имеет детей (ChildCoordinator)
   - добавить ребенка
   - удаляет ребенка, когда координатор закончит свое существование
 */
extension ParentCoordinator {
    func addChild(_ child: Coordinator) { childCoordinators.append(child) }

    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

protocol ChildCoordinator: Coordinator {
    func coordinatorDidFinish()
}
