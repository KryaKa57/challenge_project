//
//  FinalViewController.swift
//  Booking-Hotel
//
//  Created by Alisher on 18.01.2024.
//

import Foundation
import UIKit

class FinalViewController: UIViewController {
    let finalView: FinalView
    let navigationManager = NavigationManager()

    override func loadView() {
        view = finalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        navigationManager.delegate = self
        finalView.nextButton.addTarget(self, action: #selector(goBackToFirstScreen), for: .touchUpInside)
    }
    
    init(view: FinalView) {
        finalView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNavigation() {
        navigationManager.setupNavigationBar(self, title: "Заказ оплачен", hasLeftItem: true)
    }
    
    @objc func goBackToFirstScreen() {
        if let navigationController = self.navigationController {
            if let hotelViewController = navigationController.viewControllers.first(where: { $0 is HotelViewController }) {
                navigationController.popToViewController(hotelViewController, animated: true)
            }
        }
    }
}

extension FinalViewController: NavigationManagerDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
