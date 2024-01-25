//
//  BookingView.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit
import SnapKit
import JVFloatLabeledTextField

class BookingView: UIView {
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.backgroundColor = Color.background().getUIColor()
        return scrollView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    
    lazy var mainInfoStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.spacing = 8
        return stack
    }()
    
    lazy var ratingButton: PaddedButton = {
        let button = PaddedButton(padding: CGSize(width: 20, height: 10))
        let color = Color.yellow()
        button.setImage(UIImage(systemName: TextConstants.starIcon), for: .normal)
        button.setTitleColor(color.getUIColor(), for: .normal)
        button.tintColor = color.getUIColor()
        button.backgroundColor = Color.brightYellow().getUIColor()
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()

    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = FontConstant.medium().getUIFont(size: 22)
        return label
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.blue().getUIColor()
        label.numberOfLines = 0
        label.font = FontConstant.regular().getUIFont(size: 14)
        return label
    }()
    
    lazy var detailedInfoStackView: CustomStackView = {
        let stack = CustomStackView()
        return stack
    }()
    
    lazy var bookingInfoTableView: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.isUserInteractionEnabled = false
        table.separatorStyle = .none
        table.register(InfoTableCell.self, forCellReuseIdentifier: InfoTableCell.reuseIdentifier)
        return table
    }()
    
    lazy var customerInfoStackView: CustomStackView = {
        let stack = CustomStackView()
        return stack
    }()
    
    lazy var customerInfoLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.infoAboutTourist 
        label.font = FontConstant.medium().getUIFont(size: 22)
        label.textColor = .black
        return label
    }()
    
    lazy var phoneNumberTextField: JVFloatLabeledTextField = {
        let textField = JVFloatLabeledTextField()
        textField.setup(placholderText: TextConstants.phoneNumberPlaceholderText)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    lazy var emailTextField: JVFloatLabeledTextField = {
        let textField = JVFloatLabeledTextField()
        textField.setup(placholderText: TextConstants.emailPlaceholderText)
        return textField
    }()
    
    lazy var additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.additionalInfoText
        label.font = FontConstant.regular().getUIFont(size: 14)
        label.textColor = Color.gray().getUIColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var allTouristStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.backgroundColor = .clear
        return stack
    }()
    
    lazy var firstTouristStackView: TouristStackView = {
        let stack = TouristStackView(textValue: TextConstants.firstTitleText)
        return stack
    }()
    
    lazy var addTouristStackView: CustomStackView = {
        let stack = CustomStackView()
        return stack
    }()
    
    lazy var addTouristHeaderStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        return stack
    }()
    
    lazy var addTouristLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.addTouristLabelText
        label.font = FontConstant.medium().getUIFont(size: 22)
        label.textColor = .black
        return label
    }()
    
    lazy var addButton: PaddedButton = {
        let button = PaddedButton(padding: CGSize(width: 0, height: 10))
        let color = Color.blue()
        button.setImage(UIImage(systemName: TextConstants.plusIcon), for: .normal)
        button.tintColor = .white
        button.backgroundColor = color.getUIColor()
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var bookingPriceStackView: CustomStackView = {
        let stack = CustomStackView()
        return stack
    }()
    
    lazy var bookingPriceTableView: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.isUserInteractionEnabled = false
        table.separatorStyle = .none
        table.register(InfoTableCell.self, forCellReuseIdentifier: InfoTableCell.reuseIdentifier)
        return table
    }()
    
    lazy var nextButton: UIButton = {
        let button = CustomButton(textValue: TextConstants.thirdNextButtonText)
        return button
    }()
    
    lazy var bottomView: CustomStackView = {
        let stack = CustomStackView()
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 40, right: 16)
        stack.layer.cornerRadius = 0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let borderLayer = CustomBorderLayer(width: bottomView.bounds.size.width)
        bottomView.layer.addSublayer(borderLayer)
    }
    
    func configure(_ info: Booking) {
        nameLabel.text = info.hotelName
        //nameLabel.text = "Steigenberger Makadi"
        adressLabel.text = info.hotelAdress
        let attributes: [NSAttributedString.Key: Any] = [ .font: FontConstant.regular().getUIFont() ]
        let attributedText = NSAttributedString(string: "\(info.horating) \(info.ratingName)", attributes: attributes)
        ratingButton.setAttributedTitle(attributedText, for: .normal)
        
        let formattedPrice = (info.serviceCharge + info.fuelCharge + info.tourPrice).getPrice()
        let attributedTextForButton = NSAttributedString(string: "Оплатить \(formattedPrice)", attributes: attributes)
        nextButton.setAttributedTitle(attributedTextForButton, for: .normal)
    }
    
    private func initialize() {
        backgroundColor = .white
        
        mainInfoStackView.addArrangedSubview(ratingButton)
        mainInfoStackView.addArrangedSubview(nameLabel)
        mainInfoStackView.addArrangedSubview(adressLabel)
        
        detailedInfoStackView.addArrangedSubview(bookingInfoTableView)
        
        customerInfoStackView.addArrangedSubview(customerInfoLabel)
        customerInfoStackView.addArrangedSubview(phoneNumberTextField)
        customerInfoStackView.addArrangedSubview(emailTextField)
        customerInfoStackView.addArrangedSubview(additionalInfoLabel)
        customerInfoStackView.setCustomSpacing(8, after: phoneNumberTextField)
        
        allTouristStackView.addArrangedSubview(firstTouristStackView)
        
        addTouristHeaderStackView.addArrangedSubview(addTouristLabel)
        addTouristHeaderStackView.addArrangedSubview(addButton)
        addTouristStackView.addArrangedSubview(addTouristHeaderStackView)

        bookingPriceStackView.addArrangedSubview(bookingPriceTableView)
        
        bottomView.addArrangedSubview(nextButton)
        
        mainStackView.addArrangedSubview(mainInfoStackView)
        mainStackView.addArrangedSubview(detailedInfoStackView)
        mainStackView.addArrangedSubview(customerInfoStackView)
        mainStackView.addArrangedSubview(allTouristStackView)
        mainStackView.addArrangedSubview(addTouristStackView)
        mainStackView.addArrangedSubview(bookingPriceStackView)
        mainStackView.addArrangedSubview(bottomView)
        
        mainScrollView.addSubview(mainStackView)
        addSubview(mainScrollView)
        
        mainScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.systemHeight * 0.1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(32)
        }
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        bookingInfoTableView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(300)
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        addTouristHeaderStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
        }
        bookingPriceTableView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(170)
        }
        
        bottomView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
    }
    
    func isPhoneNumberFilled() -> Bool {
        return !(phoneNumberTextField.text?.isEmpty ?? true)
                || !(phoneNumberTextField.text?.contains("*") ?? true)
    }
}
