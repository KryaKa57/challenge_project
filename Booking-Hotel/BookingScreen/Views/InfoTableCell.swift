//
//  InfoTableCell.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit
import SnapKit

class InfoTableCell: UITableViewCell {
    static var reuseIdentifier: String { // Идентификатор ячейки
        return String(describing: self)
    }
    
    let leftTextLabel: UILabel = { // Текст на левой части ячейки
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = FontConstant.regular().getUIFont()
        return label
    }()
    
    let rightTextLabel: UILabel = { // Текст на правой части ячейки
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = FontConstant.regular().getUIFont()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { // Инициализация ячейки
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.addSubview(leftTextLabel)
        contentView.addSubview(rightTextLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    private func setupConstraints() {
        leftTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(0.4 * contentView.frame.width)
            make.centerY.equalTo(contentView)
        }
            
        rightTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(0.4 * contentView.frame.width)
            make.trailing.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
    
    func configure(leftText: String, rightText: String) { // Настройка ячейки
        leftTextLabel.text = leftText
        rightTextLabel.text = rightText
    }
    
    func distanceItems() { // Метод для выравнивания текста в правую сторону
        rightTextLabel.textAlignment = .right
    }
    
    func colorBlue() { // Покраска в синий цвет
        rightTextLabel.textColor = Color.blue().getUIColor()
        rightTextLabel.font = FontConstant.bold().getUIFont()
    }
}
