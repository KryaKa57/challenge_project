//
//  TextFieldStackView.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit
import SnapKit
import JVFloatLabeledTextField

class TextFieldStackView: UIStackView {
    var placeholders = ["Имя","Фамилия","Дата рождения"
                        ,"Гражданство","Номер загранпаспорта"
                        ,"Срок действия загранпаспорта"]
    
    init() {
        super.init(frame: .zero)
        setupStackView()
        addTextFields()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        axis = .vertical
        spacing = 8
        alignment = .fill
    }
    
    private func addTextFields() {
        for index in 0..<placeholders.count {
            let textField = JVFloatLabeledTextField()
            textField.setup(placholderText: placeholders[index])
            addArrangedSubview(textField)
            textField.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
}
