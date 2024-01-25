//
//  RoomCell.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

class RoomCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
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

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        return label
    }()
    
    lazy var tagsView: TagLabelsView = {
        let view = TagLabelsView()
        return view
    }()

    lazy var moreInfoButton: ButtonWithTrailingImage = {
        let button = ButtonWithTrailingImage(frame: .zero, imageName: "chevron.right", rightSideImage: true, title: "Подробнее о номере  ")
        return button
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var nextButton: CustomButton = {
        let button = CustomButton(textValue: "Выбрать номер")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        scrollView.delegate = self
        contentView.addSubview(scrollView)
        contentView.addSubview(pageControl)
        contentView.addSubview(nameLabel)
        contentView.addSubview(tagsView)
        contentView.addSubview(moreInfoButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(nextButton)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(250)
            make.centerX.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.bottom).offset(-10)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-32)
        }
        tagsView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-32)
        }
        moreInfoButton.snp.makeConstraints { make in
            make.top.equalTo(tagsView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(moreInfoButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    func configure(_ info: Room) {
        pageControl.numberOfPages = info.imageUrls.count
        addImages(images: info.imageUrls)
        nameLabel.text = info.name
        tagsView.tagNames = info.peculiarities
        priceLabel.attributedText = setMutableAttributedText(info.price, info.pricePer)
        
    }
    
    
    func addImages(images: [String]) {
        for (index, imageUrl) in images.enumerated() {
            let imageView = UIImageView()
            imageView.loadImage(from: imageUrl, defaultImage: UIImage(named: "defaultImage")) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        imageView.contentMode = .scaleAspectFill
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        imageView.image = UIImage(named: "error")?.resize(targetSize: CGSize(width: 64, height: 64))
                        imageView.contentMode = .center
                    }
                    print(error.localizedDescription)
                }
            }
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: (Constant.systemWidth - 32) * CGFloat(index), y: 0, width: Constant.systemWidth - 32, height: 250)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: (Constant.systemWidth - 32) * CGFloat(images.count), height: 250)
    }
    
    func setMutableAttributedText(_ price: Int, _ forIt: String) -> NSMutableAttributedString {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        guard let formattedString = formatter.string(from: NSNumber(value: price))
              else { return NSMutableAttributedString() }
            
        let text = "\(formattedString) ₽ \(forIt.lowercased())"
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.font, value: UIFont(name: "SFProDisplay-Bold", size: 30)!, range: NSRange(location: 0, length: formattedString.count + 2))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: formattedString.count + 2))
        
        attributedString.addAttribute(.font, value: Constant.defaultFont, range: NSRange(location: formattedString.count + 2, length: forIt.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor(rgb: 0x828796), range: NSRange(location: formattedString.count + 2, length: forIt.count))
        return attributedString
    }
}


extension RoomCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}
