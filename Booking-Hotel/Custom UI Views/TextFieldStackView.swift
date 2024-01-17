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

struct TextFieldData {
    let placeholder: String
    let isNumberPad: Bool
    let isDate: Bool
}

class TextFieldStackView: UIStackView {
    var data = [TextFieldData(placeholder: "Имя", isNumberPad: false, isDate: false)
                ,TextFieldData(placeholder: "Фамилия", isNumberPad: false, isDate: false)
                ,TextFieldData(placeholder: "Дата рождения", isNumberPad: true, isDate: true)
                ,TextFieldData(placeholder: "Гражданство", isNumberPad: false, isDate: false)
                ,TextFieldData(placeholder: "Номер загранпаспорта", isNumberPad: true, isDate: false)
                ,TextFieldData(placeholder: "Срок действия загранпаспорта", isNumberPad: true, isDate: true)]
    
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
        for index in 0..<data.count {
            let textField = JVFloatLabeledTextField()
            textField.setup(placholderText: data[index].placeholder)
            textField.delegate = self
            if data[index].isNumberPad { textField.keyboardType = .numberPad }
            addArrangedSubview(textField)
            textField.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
}

extension TextFieldStackView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if let index = subviews.firstIndex(of: textField), data[index].isDate {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(date: newString)
            return false
        }
        
        return true
    }
    
    func format(date: String) -> String {
        let numbers = date.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let mask = "****-**-**"
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "*" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
    
    
}
