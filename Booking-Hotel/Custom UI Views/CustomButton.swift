//
//  CustomButton.swift
//  Booking-Hotel
//
//  Created by Alisher on 16.01.2024.
//

import Foundation
import UIKit

class CustomButton: UIButton { // Класс для создания кастомной кнопки

    let padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 5) // Отступы для текста

    var textValue: String // Текст кнопки

    override var isEnabled: Bool {
        didSet {
            let color = Color.blue()
            if isEnabled {
                // Если кнопка активна, красим цвет фона в синий
                self.backgroundColor = color.getUIColor()
            } else {
                // Если кнопка неактивна, то добавляем прозрачность
                self.backgroundColor = color.getUIColor(opacity: 0.1)
            }
        }
    }

    required init(textValue: String) { // Инициализация вида
        self.textValue = textValue
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }

    private func setup() { // Настройки вида
        self.setTitle(textValue, for: .normal)
        self.titleLabel?.font = FontConstant.regular().getUIFont(size: 16)
        self.backgroundColor = Color.blue().getUIColor()
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 12
    }
}
