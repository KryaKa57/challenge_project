//
//  HotelView.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit
import SnapKit

class HotelView: UIView {
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.backgroundColor = Color.background().getUIColor()
        return scrollView
    }()
    
    lazy var mainInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.alignment = .leading
        stack.axis = .vertical
        stack.backgroundColor = .white
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.cornerRadius = 12
        stack.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return stack
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layer.cornerRadius = 16
        scrollView.clipsToBounds = true
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var pageControl: CustomPageControl = {
        let pageControl = CustomPageControl()
        return pageControl
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
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var detailedInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.alignment = .leading
        stack.axis = .vertical
        stack.backgroundColor = .white
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.cornerRadius = 12
        return stack
    }()
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.aboutHotel
        label.textColor = .black
        label.font = FontConstant.medium().getUIFont(size: 22)
        return label
    }()
    
    lazy var tagsView: TagLabelsView = {
        let view = TagLabelsView()
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = FontConstant.regular().getUIFont()
        return label
    }()
    
    lazy var moreInfoTabelView: UITableView = {
        let table = UITableView()
        table.register(MoreInfoCell.self, forCellReuseIdentifier: MoreInfoCell.reuseIdentifier)
        table.layer.cornerRadius = 16
        table.separatorInset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 16)
        return table
    }()
    
    lazy var nextButton: UIButton = {
        let button = CustomButton(textValue: TextConstants.firstNextButtonText)
        return button
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        pageControl.currentPage = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let borderLayer = CustomBorderLayer(width: bottomView.bounds.size.width)
        bottomView.layer.addSublayer(borderLayer)
    }
    
    func addImages(images: [String]) {
        for (index, imageUrl) in images.enumerated() {
            let imageView = UIImageView()
            imageView.loadImage(from: imageUrl)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: scrollView.frame.width * CGFloat(index), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(imageView)
        }

        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(images.count), height: scrollView.frame.height)
        
    }
    
    func configure(_ info: Hotel) {
        pageControl.numberOfPages = info.imageUrls.count
        addImages(images: info.imageUrls)
        nameLabel.text = info.name
        //nameLabel.text = "Steigenberger Makadi"
        adressLabel.text = info.adress
        tagsView.tagNames = info.aboutTheHotel.peculiarities
        descriptionLabel.text = info.aboutTheHotel.description
        priceLabel.attributedText = setMutableAttributedText(info.minimalPrice, info.priceForIt)
        let attributes: [NSAttributedString.Key: Any] = [ .font: FontConstant.regular().getUIFont() ]
        let attributedText = NSAttributedString(string: "\(info.rating) \(info.ratingName)", attributes: attributes)
        ratingButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    func setMutableAttributedText(_ price: Int, _ forIt: String) -> NSMutableAttributedString {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        guard let formattedString = formatter.string(from: NSNumber(value: price))
              else { return NSMutableAttributedString() }
            
        let text = "От \(formattedString) ₽ \(forIt.lowercased())"
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.font, value: FontConstant.bold().getUIFont(size: 30), range: NSRange(location: 0, length: 6 + formattedString.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 13))
        
        attributedString.addAttribute(.font, value: FontConstant.regular().getUIFont(), range: NSRange(location: 13, length: 18))
        attributedString.addAttribute(.foregroundColor, value: Color.gray().getUIColor(), range: NSRange(location: 13, length: forIt.count))
        return attributedString
    }
    
    private func initialize() {
        backgroundColor = .white
        
        mainInfoStack.addArrangedSubview(scrollView)
        mainInfoStack.addArrangedSubview(ratingButton)
        mainInfoStack.addArrangedSubview(nameLabel)
        mainInfoStack.addArrangedSubview(adressLabel)
        mainInfoStack.addArrangedSubview(priceLabel)
        mainInfoStack.setCustomSpacing(8, after: ratingButton)
        mainInfoStack.setCustomSpacing(8, after: nameLabel)
        mainScrollView.addSubview(mainInfoStack)
        mainScrollView.addSubview(pageControl)
        
        detailedInfoStack.addArrangedSubview(aboutLabel)
        detailedInfoStack.addArrangedSubview(tagsView)
        detailedInfoStack.addArrangedSubview(descriptionLabel)
        detailedInfoStack.addArrangedSubview(moreInfoTabelView)
        mainScrollView.addSubview(detailedInfoStack)
        
        bottomView.addSubview(nextButton)
        mainScrollView.addSubview(bottomView)
        addSubview(mainScrollView)
        
        mainScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.systemHeight * 0.1)
            make.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(250)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.bottom).offset(-10)
        }
        mainInfoStack.snp.makeConstraints { make in
            make.top.leading.width.equalToSuperview()
        }
        detailedInfoStack.snp.makeConstraints { make in
            make.top.equalTo(mainInfoStack.snp.bottom).offset(8)
            make.width.equalToSuperview()
        }
        moreInfoTabelView.snp.makeConstraints { make in
            make.height.equalTo(195)
            make.width.equalToSuperview().offset(-32)
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(detailedInfoStack.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(96)
            make.bottom.equalToSuperview().offset(32)
        }
        nextButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
    }
}
