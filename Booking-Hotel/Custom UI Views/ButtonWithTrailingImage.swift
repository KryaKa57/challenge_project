//
//  ButtonWithTrailingImage.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

class ButtonWithTrailingImage: PaddedButton {
    // Класс кнопки с изображением справа + наследие отступа
    var rightSideImage = false // Флаг для размещения изображения справа
    var title: String = ""
    var imageName: String = ""
    init(frame: CGRect, imageName: String, rightSideImage: Bool = false, title: String) {
        self.rightSideImage = rightSideImage
        self.title = title
        self.imageName = imageName
        super.init(padding: CGSize(width: 0, height: 0))
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    required init(padding: CGSize) {
        fatalError(TextConstants.fatalErrorText)
    }
    private func commonInit() {
        // Создание изображения
        let color = Color.blue()
        let image = UIImage(systemName: imageName,
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))?.withTintColor(color.getUIColor(), renderingMode: .alwaysOriginal)
        setImage(image, for: .normal)
        backgroundColor = color.getUIColor(opacity: 0.1)
        layer.cornerRadius = 5
        isEnabled = false

        // Настройка для размещения изображения справа
        if rightSideImage {
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .trailing
            self.configuration = configuration
        }

        // Создание атрибутированного текста
        let attributes: [NSAttributedString.Key: Any] = [ .font: FontConstant.regular().getUIFont(),
                                                          .foregroundColor: color.getUIColor()]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedText, for: .normal)
    }

}
