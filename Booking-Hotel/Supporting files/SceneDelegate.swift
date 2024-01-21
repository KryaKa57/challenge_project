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
        
        
        let hotelViewController = HotelViewController(viewModel: HotelViewModel())
        window?.rootViewController = UINavigationController(rootViewController: hotelViewController)
        window?.makeKeyAndVisible()
        
//        let navigationController = UINavigationController()
//        navigationController.setNavigationBarHidden(true, animated: false)
//        let coordinator = AppCoordinator(navigationController: navigationController)
//        coordinator.start(animated: false)
//
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
    }
    
}
