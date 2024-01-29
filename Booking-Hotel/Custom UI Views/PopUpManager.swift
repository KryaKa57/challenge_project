//
//  PopUpManager.swift
//  Booking-Hotel
//
//  Created by Alisher on 26.01.2024.
//

import Foundation
import UIKit

class PopupManager {
    static func showLoginFailurePopUp(on view: UIView, message: String) {
        // Метод для вызова всплывающего окна

        // Свойства всплывающего окна
        let safeAreaTopInset = view.safeAreaInsets.top
        let popUpView = UIView(frame: CGRect(x: 32, y: safeAreaTopInset - 64, width: view.frame.width - 64, height: 48))
        let errorColor = UIColor.red
        popUpView.layer.borderWidth = 1.0
        popUpView.layer.borderColor = errorColor.cgColor
        popUpView.layer.cornerRadius = 16
        popUpView.backgroundColor = .white

        // Инициализация и добавление иконки
        let iconImage = UIImage(systemName: TextConstants.exlamationmarkIcon)
        let iconImageView = UIImageView(frame: CGRect(x: 16, y: popUpView.frame.height/2 - 16, width: 32, height: 32))
        iconImageView.image = iconImage
        iconImageView.tintColor = errorColor

        // Инициализация и добавление сообщения ошибки
        let messageLabel = UILabel(frame: CGRect(x: 56, y: 0, width: popUpView.frame.width - 56, height: popUpView.frame.height))
        let textAttributes =  [
            NSAttributedString.Key.font: FontConstant.medium().getUIFont(),
            NSAttributedString.Key.foregroundColor: errorColor
            ]
        messageLabel.numberOfLines = 0
        messageLabel.attributedText = NSAttributedString(string: message,
                                                         attributes: textAttributes)

        popUpView.addSubview(iconImageView)
        popUpView.addSubview(messageLabel)
        view.addSubview(popUpView)

        // Анимация появления всплывающего окна
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            popUpView.frame.origin.y = safeAreaTopInset
        }, completion: { _ in
            // Задержка перед запуском анимации исчезновения всплывающего окна
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.animate(withDuration: 0.5, animations: {
                    popUpView.frame.origin.y = safeAreaTopInset - 64
                }, completion: { _ in
                    // Удаление всплывающего окна после завершения анимации
                    popUpView.removeFromSuperview()
                })
            }
        })
    }
}
