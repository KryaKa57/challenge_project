//
//  SceneDelegate.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let navigationController = UINavigationController()
        let coordinator = HotelCoordinator(navigationController: navigationController)
        coordinator.start(animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
