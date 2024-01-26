//
//  RoomCell.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

class RoomCell: UICollectionViewCell {
    static var reuseIdentifier: String { // Идентификатор ячейки
        return String(describing: self)
    }
    
    lazy var scrollView: UIScrollView = { // Карусель фотографии
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.layer.cornerRadius = 16
        scrollView.clipsToBounds = true
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var pageControl: CustomPageControl = { // Кастомный контрол страницы
        let pageControl = CustomPageControl()
        return pageControl
    }()

    lazy var nameLabel: UILabel = { // Название типа комнаты
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = FontConstant.medium().getUIFont(size: 22)
        return label
    }()
    
    lazy var tagsView: TagLabelsView = { // Тэги удобств комнат
        let view = TagLabelsView()
        return view
    }()

    lazy var moreInfoButton: ButtonWithTrailingImage = { // Кнопка для ознакомления подробнее о комнате
        let button = ButtonWithTrailingImage(frame: .zero, imageName: TextConstants.chevronRightIcon, rightSideImage: true, title: TextConstants.moreAboutHotel)
        return button
    }()
    
    lazy var priceLabel: UILabel = { // Цена для аренды комнаты
        let label = UILabel()
        return label
    }()
    
    lazy var nextButton: CustomButton = { // Кнопка для перехода на следующий экран
        let button = CustomButton(textValue: TextConstants.secondNextButtonText)
        return button
    }()
    
    override init(frame: CGRect) { // Инициализация ячейки
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
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
    
    func configure(_ info: Room) { // Настройки ячейки с помощью информации о комнате
        pageControl.numberOfPages = info.imageUrls.count
        addImages(images: info.imageUrls)
        nameLabel.text = info.name
        tagsView.tagNames = info.peculiarities
        priceLabel.attributedText = setMutableAttributedText(info.price, info.pricePer)
    }
    
    func addImages(images: [String]) {
        // Загрузка фото с URL ссылки и добавление их в карусель
        for (index, imageUrl) in images.enumerated() {
            // Создание вьюшки для фотографии
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: (Constant.systemWidth - 32) * CGFloat(index), y: 0, width: Constant.systemWidth - 32, height: 250)
            // Загрузка изображения
            NetworkManager.loadImage(from: imageUrl) { result in
                switch result {
                case .success(let res):
                    // При успешной загрузке изображения сохраняем ее в вид
                    DispatchQueue.main.async {
                        imageView.image = res
                        imageView.contentMode = .scaleAspectFill
                    }
                case .failure(_):
                    // При некорректной загрузки изображения указываем дефолт и в центре вьюшки
                    DispatchQueue.main.async {
                        imageView.image = UIImage(named: TextConstants.errorText)?.resize(targetSize: CGSize(width: 64, height: 64))
                        imageView.contentMode = .center
                    }
                }
            }
            scrollView.addSubview(imageView) // Добавление вьюшки в карусель
        }
        // Установка размера карусели в соответствии с количеством изображений
        scrollView.contentSize = CGSize(width: (Constant.systemWidth - 32) * CGFloat(images.count), height: 250)
    }
    
    func setMutableAttributedText(_ price: Int, _ forIt: String) -> NSMutableAttributedString {
        // Установка нескольких атрибутов для текста
        let formatter = NumberFormatter() // Инициализация модуля для формата
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        // Форматирование цены в строку используя модуль для формата
        guard let formattedString = formatter.string(from: NSNumber(value: price))
              else { return NSMutableAttributedString() }
        
        // Создание текста
        let text = "\(formattedString) ₽ \(forIt.lowercased())"
        let attributedString = NSMutableAttributedString(string: text)
        
        // Установка атрибута для первой части текста
        attributedString.addAttribute(.font, value: FontConstant.bold().getUIFont(size: 30), range: NSRange(location: 0, length: formattedString.count + 2))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: formattedString.count + 2))
        
        // Установка атрибута для второй части текста
        attributedString.addAttribute(.font, value: FontConstant.regular().getUIFont(), range: NSRange(location: formattedString.count + 2, length: forIt.count))
        attributedString.addAttribute(.foregroundColor, value: Color.gray().getUIColor(), range: NSRange(location: formattedString.count + 2, length: forIt.count))
        return attributedString
    }
}

extension RoomCell: UIScrollViewDelegate {
    // Делегат для скролинга карусели фотографии
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}
