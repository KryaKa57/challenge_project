//
//  TouristStackView.swift
//  Booking-Hotel
//
//  Created by Alisher on 18.01.2024.
//

import Foundation
import UIKit

class TouristStackView: CustomStackView {
    lazy var touristHeaderStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        return stack
    }()
    
    lazy var numberTouristLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.firstTouristText
        label.font = FontConstant.medium().getUIFont(size: 22)
        label.textColor = .black
        return label
    }()
    
    lazy var toggleButton: PaddedButton = {
        let button = PaddedButton(padding: CGSize(width: 10, height: 0))
        let color = Color.blue()
        button.setImage(UIImage(systemName: TextConstants.chevronUpIcon), for: .normal)
        button.tintColor = color.getUIColor()
        button.backgroundColor = color.getUIColor(opacity: 0.1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var dropdownStackView: TextFieldStackView = {
        let stackView = TextFieldStackView()
        return stackView
    }()
    
    required init(textValue: String) {
        super.init()
        self.numberTouristLabel.text = textValue
        setup()
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    required init() {
        fatalError(TextConstants.fatalErrorText)
    }
    
    private func setup() {
        toggleButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        
        touristHeaderStackView.addArrangedSubview(numberTouristLabel)
        touristHeaderStackView.addArrangedSubview(toggleButton)
        addArrangedSubview(touristHeaderStackView)
        addArrangedSubview(dropdownStackView)
        
        toggleButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        touristHeaderStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
        }
        dropdownStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(340)
        }
    }
        
    @objc func toggleDropdown() {
        UIView.animate(withDuration: 0.3) {
            self.dropdownStackView.isHidden = !self.dropdownStackView.isHidden
            let image = UIImage(systemName: (self.dropdownStackView.isHidden ? TextConstants.chevronDownIcon : TextConstants.chevronUpIcon))
            self.toggleButton.setImage(image, for: .normal)
            self.layoutIfNeeded()
        }
    }
}
