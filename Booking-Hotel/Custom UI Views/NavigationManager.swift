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

class NavigationManager { // Менеджер навигации для перехода
    weak var delegate: NavigationManagerDelegate? // Создание переменной делегата

    func setupNavigationBar(_ vc: UIViewController, title: String = "",
                            hasLeftItem: Bool = false) {
        vc.navigationItem.setHidesBackButton(true, animated: true) // Скрываем кнопку дефолтную

        if title != "" { // Если текст заглавие не пуста, то добавляем ее
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.textColor = UIColor.black
            titleLabel.font = FontConstant.regular().getUIFont(size: 18)
            vc.navigationItem.titleView = titleLabel
        }

        if hasLeftItem { // Если true, то добавляем элемент кнопки "назад"
            let leftButtonItem = getLeftItem()
            vc.navigationItem.leftBarButtonItem = leftButtonItem
        }
    }

    func getLeftItem() -> UIBarButtonItem { // создание кнопки "назад"
        let leftButton: UIButton = {
            let button = UIButton()
            let image = UIImage(systemName: TextConstants.chevronLeftIcon)
            button.setImage(image, for: .normal)
            button.tintColor = .black
            button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
            return button
        }()

        return UIBarButtonItem(customView: leftButton)
    }

    @objc func leftButtonTapped() { // вызов делегата через таргет кнопки
        delegate?.backButtonTapped()
    }

}
