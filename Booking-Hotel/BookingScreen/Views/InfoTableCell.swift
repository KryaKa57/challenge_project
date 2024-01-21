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
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let leftTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = Constant.defaultFont
        return label
    }()
    
    let rightTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = Constant.defaultFont
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.addSubview(leftTextLabel)
        contentView.addSubview(rightTextLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func configure(leftText: String, rightText: String) {
        leftTextLabel.text = leftText
        rightTextLabel.text = rightText
    }
    
    func distanceItems() {
        rightTextLabel.textAlignment = .right
    }
    
    func colorBlue() {
        rightTextLabel.textColor = UIColor(rgb: 0x0D72FF)
        rightTextLabel.font = UIFont(name: "SFProDisplay-Bold", size: 16)
    }
}
