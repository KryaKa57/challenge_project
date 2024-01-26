//
//  FinalView.swift
//  Booking-Hotel
//
//  Created by Alisher on 18.01.2024.
//

import Foundation
import UIKit
import SnapKit

class FinalView: UIView {    
    lazy var mainStackView: UIStackView = { // Стак для всех элементов
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    lazy var partyImageView: UIImageView = { // Изображение "вечеринки"
        let imageView = UIImageView()
        let image = UIImage(named: TextConstants.partyPopperIcon)?.resize(targetSize: CGSize(width: 44, height: 44))
        imageView.image = image
        imageView.backgroundColor = Color.background().getUIColor()
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var titleLabel: UILabel = { // Заглавный текст
        let label = UILabel()
        label.text = TextConstants.orderAcceptedText
        label.textColor = .black
        label.textAlignment = .center
        label.font = FontConstant.regular().getUIFont(size: 22)
        return label
    }()
    
    lazy var additionalLabel: UILabel = { // Дополнительный текст
        let label = UILabel()
        label.text = TextConstants.additionalLabelText
        label.textColor = Color.gray().getUIColor()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = FontConstant.regular().getUIFont()
        return label
    }()
    
    lazy var nextButton: UIButton = { // Кнопка перехода на следующий экран
        let button = CustomButton(textValue: TextConstants.coolText)
        return button
    }()
    
    lazy var bottomView: CustomStackView = { // Вьюшка для нижней части экрана
        let stack = CustomStackView()
        stack.layer.cornerRadius = 0
        return stack
    }()
    
    override init(frame: CGRect) { // Инициализация вида
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let borderLayer = CustomBorderLayer(width: bottomView.bounds.size.width)
        bottomView.layer.addSublayer(borderLayer) // Добавление границы в нижнюю часть экрана
    }
    
    
    private func initialize() { // Настройка вида
        backgroundColor = .white
        
        mainStackView.addArrangedSubview(partyImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(additionalLabel)
        bottomView.addArrangedSubview(nextButton)
        addSubview(mainStackView)
        addSubview(bottomView)
        
        mainStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-32)
        }
        bottomView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
        partyImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
    }
}
