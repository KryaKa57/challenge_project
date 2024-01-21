//
//  MoreInfoCell.swift
//  Booking-Hotel
//
//  Created by Alisher on 16.01.2024.
//

import Foundation
import UIKit

class MoreInfoCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    lazy var leftIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emoji-happy")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Удобства"
        label.textColor = .black
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Самое необходимое"
        label.textColor = UIColor(rgb: 0x828796)
        return label
    }()
    
    lazy var rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(_ info: MoreInformation) {
        isUserInteractionEnabled = false
        leftIconImageView.image = UIImage(named: info.imageName)
        titleLabel.text = info.title
    }
    
    private func setupViews() {
        backgroundColor = UIColor(rgb: 0xFBFBFC)
        addSubview(leftIconImageView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(detailLabel)
        addSubview(titleStackView)
        addSubview(rightIconImageView)
        
        leftIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.leading.equalTo(leftIconImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        rightIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
}
