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
        label.text = "Первый турист"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        label.textColor = .black
        return label
    }()
    
    lazy var toggleButton: UIButton = {
        let button = UIButton()
        let color = Color.blue
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.tintColor = color.getTitleColor()
        button.backgroundColor = color.getBackgroundColor()
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
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
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
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
            let image = UIImage(systemName: (self.dropdownStackView.isHidden ? "chevron.down" : "chevron.up"))
            self.toggleButton.setImage(image, for: .normal)
            self.layoutIfNeeded()
        }
    }
}
