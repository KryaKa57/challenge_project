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
    
    lazy var mainScrollView: UIScrollView = { // Вьюшка для скроллинга всего экрана
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.backgroundColor = Color.background().getUIColor()
        return scrollView
    }()
    
    lazy var mainInfoStack: UIStackView = { // Стак для основных данных отеля
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
    
    lazy var scrollView: UIScrollView = { // Карусель фотографии
        let scrollView = UIScrollView()
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
    
    lazy var ratingButton: PaddedButton = { // Кнопка с рейтингом отеля
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
    
    lazy var nameLabel: UILabel = { // Название отеля
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = FontConstant.medium().getUIFont(size: 22)
        return label
    }()
    
    lazy var adressLabel: UILabel = { // Адрес отеля
        let label = UILabel()
        label.textColor = Color.blue().getUIColor()
        label.numberOfLines = 0
        label.font = FontConstant.regular().getUIFont(size: 14)
        return label
    }()
    
    lazy var priceLabel: UILabel = { // Минимальная цена
        let label = UILabel()
        return label
    }()
    
    lazy var detailedInfoStack: UIStackView = { // Стак для подробных данных отеля
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
    
    lazy var aboutLabel: UILabel = { // Заголовок стака
        let label = UILabel()
        label.text = TextConstants.aboutHotel
        label.textColor = .black
        label.font = FontConstant.medium().getUIFont(size: 22)
        return label
    }()
    
    lazy var tagsView: TagLabelsView = { // Тэги отеля
        let view = TagLabelsView()
        return view
    }()
    
    lazy var descriptionLabel: UILabel = { // Описание отеля
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = FontConstant.regular().getUIFont()
        return label
    }()
    
    lazy var moreInfoTabelView: UITableView = { // Таблица с условиями отеля
        let table = UITableView()
        table.register(MoreInfoCell.self, forCellReuseIdentifier: MoreInfoCell.reuseIdentifier)
        table.layer.cornerRadius = 16
        table.separatorInset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 16)
        return table
    }()
    
    lazy var nextButton: UIButton = { // Кнопка для перехода на следующий экран
        let button = CustomButton(textValue: TextConstants.firstNextButtonText)
        return button
    }()
    
    lazy var bottomView: UIView = { // Вьюшка для нижней части экрана
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        pageControl.currentPage = 0 // При инициализации указываем первую страницу в карусели
    }
    
    required init?(coder: NSCoder) {
        fatalError(TextConstants.fatalErrorText)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let borderLayer = CustomBorderLayer(width: bottomView.bounds.size.width)
        bottomView.layer.addSublayer(borderLayer) // Добавление границы в нижнюю часть экрана
    }
    
    func configure(_ info: Hotel) { // Настройка вида с добавлением информации про Отель
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
        // Установка нескольких атрибутов для текста
        let formatter = NumberFormatter() // Инициализация модуля для формата
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        // Форматирование цены в строку используя модуль для формата
        guard let formattedString = formatter.string(from: NSNumber(value: price))
              else { return NSMutableAttributedString() }
            
        // Создание текста
        let text = "От \(formattedString) ₽ \(forIt.lowercased())"
        let attributedString = NSMutableAttributedString(string: text)
        
        // Установка атрибута для первой части текста
        attributedString.addAttribute(.font, value: FontConstant.bold().getUIFont(size: 30), range: NSRange(location: 0, length: 6 + formattedString.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 13))
        
        // Установка атрибута для второй половины текста
        attributedString.addAttribute(.font, value: FontConstant.regular().getUIFont(), range: NSRange(location: 13, length: 18))
        attributedString.addAttribute(.foregroundColor, value: Color.gray().getUIColor(), range: NSRange(location: 13, length: forIt.count))
        return attributedString
    }
    
    func addImages(images: [String]) {
        // Загрузка фото с URL ссылки и добавление их в карусель
        for (index, imageUrl) in images.enumerated() {
            // Создание вьюшки для фотографии
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: scrollView.frame.width * CGFloat(index), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            
            // Загрузка изображения
            NetworkManager.loadImage(from: imageUrl) { result in
                switch result {
                case .success(let res):
                    // При успешной загрузке изображения сохраняем ее в вид
                    DispatchQueue.main.async {
                        imageView.image = res
                        imageView.contentMode = .scaleAspectFill
                    }
                case .failure(let error):
                    // При некорректной загрузки изображения указываем дефолт и в центре вьюшки
                    DispatchQueue.main.async {
                        imageView.image = UIImage(named: TextConstants.errorText)?.resize(targetSize: CGSize(width: 64, height: 64))
                        imageView.contentMode = .center
                    }
                    print(error.localizedDescription)
                }
            }
            scrollView.addSubview(imageView) // Добавление вьюшки в карусель
        }
        
        // Установка размера карусели в соответствии с количеством изображений
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(images.count), height: scrollView.frame.height)
    }
    
    private func initialize() { // Инициализация вьюшки
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
