
//
//  NavigationManager.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation

import UIKit

protocol NavigationManagerDelegate: AnyObject {
    func backButtonTapped()
}

class NavigationManager {
    weak var delegate: NavigationManagerDelegate?
    
    func setupNavigationBar(_ vc: UIViewController, title: String = "",
                            hasLeftItem: Bool = false) {
        vc.navigationItem.setHidesBackButton(true, animated: true)
        if title != "" {
            vc.navigationItem.title = title
        }
        
        if hasLeftItem {
            let leftButtonItem = getLeftItem()
            vc.navigationItem.leftBarButtonItem = leftButtonItem
        }
    }
    
    func getLeftItem() -> UIBarButtonItem {
        let leftButton: UIButton = {
            let button = UIButton()
            let image = UIImage(systemName: "chevron.left")
            button.setImage(image, for: .normal)
            button.tintColor = .black
            button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
            return button
        }()
        
        return UIBarButtonItem(customView: leftButton)
    }
    
    @objc func leftButtonTapped() {
        delegate?.backButtonTapped()
    }
    
}
