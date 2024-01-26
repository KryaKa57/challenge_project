//
//  RoomView.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit
import SnapKit

class RoomView: UIView {
    
    lazy var collectionView: UICollectionView = { // Коллекция видов комнат
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Указываем направление прокрутки
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RoomCell.self, forCellWithReuseIdentifier: RoomCell.reuseIdentifier) // Регистрация ячейки
        collectionView.backgroundColor = Color.background().getUIColor()
        return collectionView
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
    }
    
    private func initialize() { // Инициализация вида
        backgroundColor = UIColor.white
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.systemHeight * 0.1)
            make.leading.width.bottom.equalToSuperview()
        }
    }
}
