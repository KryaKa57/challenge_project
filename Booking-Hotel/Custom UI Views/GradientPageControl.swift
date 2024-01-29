//
//  GradientPageControl.swift
//  Booking-Hotel
//
//  Created by Alisher on 25.01.2024.
//

import Foundation
import UIKit

class CustomPageControl: UIStackView {
    // Класс для стака управления каруселю фотографии

    private var dotViews: [UIView] = [] // Список индикаторов

    var numberOfPages: Int = 0 { // количество страниц
        didSet {
            // Создание или удаление индикаторов в зависимости от числа страниц
            while dotViews.count < numberOfPages {
                _ = createDot()
            }
            while dotViews.count > numberOfPages {
                let removedDot = dotViews.removeLast()
                removedDot.removeFromSuperview()
            }
            updateDots() // обновляем индикаторы
            changeSizeOfView() // изменяем размер вьюшки
        }
    }

    var currentPage: Int = 0 { // текущая страница
        didSet {
            // Обновление индикаторов при изменении текущей страницы
            updateDots()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateDots() // обновление индикатора при изменении размеров вью
    }

    private func createDot() -> UIView { // создание индикатора
        let dotView = UIView()
        dotView.layer.cornerRadius = 4
        dotView.layer.masksToBounds = true
        dotView.backgroundColor = .black
        addArrangedSubview(dotView)
        dotView.snp.makeConstraints { make in
            make.height.equalTo(8)
        }
        dotViews.append(dotView)
        return dotView
    }

    private func updateDots() { // Обновление индикатора
        let colors = generateGradientColors(count: numberOfPages)
        for (index, dotView) in dotViews.enumerated() {
            dotView.backgroundColor = colors[index]
        }

    }

    func generateGradientColors(count: Int) -> [UIColor] {
        // Генерация градиентных цветов для индикаторов
        var colors: [UIColor] = []

        for index in 0..<count {
            // текущая страница - черная, далее уже меняем яркость от того, как далеко находится индикатор от текущей страницы
            let brightness = (index == currentPage) ? 0 : (CGFloat(abs(index - currentPage)) / CGFloat(count - 1)) * 0.8
            let color = UIColor(hue: 0.0, saturation: 0.0, brightness: brightness, alpha: 1.0)
            colors.append(color)
        }

        return colors
    }

    private func changeSizeOfView() {
        // Изменение размеров стека
        snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(dotViews.count * 16 + 16)
        }
    }

    private func setup() { // Настройки стака
        layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        isLayoutMarginsRelativeArrangement = true
        backgroundColor = .white
        layer.cornerRadius = 8
        distribution = .fillEqually
        spacing = 8
        alignment = .center
        updateDots()
    }
}
