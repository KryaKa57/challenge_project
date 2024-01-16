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
        stack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
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
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.layer.cornerRadius = 8
        pageControl.backgroundColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    lazy var ratingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.setTitleColor(UIColor(rgb: 0xFFA800), for: .normal)
        button.tintColor = UIColor(rgb: 0xFFA800)
        button.backgroundColor = UIColor(rgb: 0xFFC700, alpha: 0.2)
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.isEnabled = false
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        return label
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x0D72FF)
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
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
        label.text = "Об отеле"
        label.textColor = .black
        label.font = UIFont(name: "SFProDisplay-Medium", size: 22)
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
        label.font = Constant.defaultFont
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
        let button = CustomButton(textValue: "К выбору номера")
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
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Add top border
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor(rgb: 0xE8E9EC).cgColor
        borderLayer.frame = CGRect(x: 0, y: 0, width: bottomView.bounds.size.width, height: 1)
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
        //nameLabel.text = info.name
        nameLabel.text = "Steigenberger Makadi"
        adressLabel.text = info.adress
        tagsView.tagNames = info.aboutTheHotel.peculiarities
        descriptionLabel.text = info.aboutTheHotel.description
        priceLabel.attributedText = setMutableAttributedText(info.minimalPrice, info.priceForIt)
        let attributes: [NSAttributedString.Key: Any] = [ .font: Constant.defaultFont ]
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
        
        attributedString.addAttribute(.font, value: UIFont(name: "SFProDisplay-Bold", size: 30)!, range: NSRange(location: 0, length: 6 + formattedString.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 13))
        
        attributedString.addAttribute(.font, value: Constant.defaultFont, range: NSRange(location: 13, length: 18))
        attributedString.addAttribute(.foregroundColor, value: UIColor(rgb: 0x828796), range: NSRange(location: 13, length: forIt.count))
        return attributedString
    }
    
    private func initialize() {
        backgroundColor = UIColor(rgb: 0xF6F6F9)
        mainInfoStack.addArrangedSubview(scrollView)
        mainInfoStack.addArrangedSubview(ratingButton)
        mainInfoStack.addArrangedSubview(nameLabel)
        mainInfoStack.addArrangedSubview(adressLabel)
        mainInfoStack.addArrangedSubview(priceLabel)
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
            make.top.leading.width.height.equalToSuperview()
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
