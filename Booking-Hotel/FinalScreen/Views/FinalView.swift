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
    lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    lazy var partyImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "party-popper")?.resize(targetSize: CGSize(width: 44, height: 44))
        imageView.image = image
        imageView.backgroundColor = UIColor(rgb: 0xF6F6F9)
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш заказ принят в работу"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Regular", size: 22)
        return label
    }()
    
    lazy var additionalLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение заказа №\(getRandomId()) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
        label.textColor = UIColor(rgb: 0x828796)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Constant.defaultFont
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = CustomButton(textValue: "Супер!")
        return button
    }()
    
    lazy var bottomView: CustomStackView = {
        let stack = CustomStackView()
        stack.layer.cornerRadius = 0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor(rgb: 0xE8E9EC).cgColor
        borderLayer.frame = CGRect(x: 0, y: 0, width: bottomView.bounds.size.width, height: 1)
        bottomView.layer.addSublayer(borderLayer)
    }
    
    func getRandomId() -> Int {
        return Int(arc4random_uniform(900000) + 100000)
    }
    
    private func initialize() {
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
