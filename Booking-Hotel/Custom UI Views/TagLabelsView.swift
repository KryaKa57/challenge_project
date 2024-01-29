//
//  TagLabelsView.swift
//  Booking-Hotel
//
//  Created by Alisher on 16.01.2024.
//

import Foundation
import UIKit

class TagLabelsView: UIView {
    // Вьюшка с тэгами

    var tagNames: [String] = [] { // Список тэгов
        didSet {
            addTagLabels() // При изменении списка вызываем метод
        }
    }

    // Параметры тэга
    let tagHeight: CGFloat = 30
    let tagPadding: CGFloat = 16
    let tagSpacingX: CGFloat = 8
    let tagSpacingY: CGFloat = 8

    var intrinsicHeight: CGFloat = 0

    override init(frame: CGRect) { // Инициализация вьюшки
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override var intrinsicContentSize: CGSize { // меняем внутренний размер вида
        var sz = super.intrinsicContentSize
        sz.height = intrinsicHeight
        return sz
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        displayTagLabels() // При изменении размера вьюхи, вызываем метод displayTagLabels
    }

    func addTagLabels() { // Метод для добавления тэгов в список

        // Если подвью больше чем тэгов, то удаляем лишние подвью
        while self.subviews.count > tagNames.count {
            self.subviews[0].removeFromSuperview()
        }

        while self.subviews.count < tagNames.count {
            // Если подвью меньше чем тэгов, то добавляем новые подвью для каждого тэга
            let newLabel = UILabel()
            newLabel.textAlignment = .center
            newLabel.backgroundColor = Color.lightGray().getUIColor()
            newLabel.layer.masksToBounds = true
            newLabel.layer.cornerRadius = 5
            newLabel.textColor = Color.gray().getUIColor()
            newLabel.font = FontConstant.regular().getUIFont()
            addSubview(newLabel)
        }

        // Обновляем текст и размеры каждого подвью в соответствии с тэгами
        for (str, subview) in zip(tagNames, self.subviews) {
            guard let label = subview as? UILabel else {
                fatalError(TextConstants.fatalLabelErrorText)
            }
            label.text = str
            label.frame.size.width = label.intrinsicContentSize.width + tagPadding
            label.frame.size.height = tagHeight
        }

    }

    func displayTagLabels() {
        // Метод для отображения тэгов

        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0

        self.subviews.forEach { subview in // Перебор всех подвью

            guard let label = subview as? UILabel else {
                fatalError(TextConstants.fatalLabelErrorText)
            }

            if currentOriginX + label.frame.width > Constant.systemWidth - 32 {
                // Если следующий тэг не помещается в текущей строке, переходим на новую строку
                currentOriginX = 0
                currentOriginY += tagHeight + tagSpacingY
            }
            // Устанавливаем координаты для текущего тэга
            label.frame.origin.x = currentOriginX
            label.frame.origin.y = currentOriginY

            // Обновляем координату X для следующего тэга
            currentOriginX += label.frame.width + tagSpacingX
        }
        // Обновляем высоту для корректного отображения в StackView или других контейнерах
        intrinsicHeight = currentOriginY + tagHeight
        invalidateIntrinsicContentSize()
    }

}
