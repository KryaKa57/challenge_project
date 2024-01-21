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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RoomCell.self, forCellWithReuseIdentifier: RoomCell.reuseIdentifier)
        collectionView.backgroundColor = UIColor(rgb: 0xF6F6F9)
        return collectionView
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
    }
    
    func configure() {
    }
    
    private func initialize() {
        backgroundColor = UIColor.white
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.systemHeight * 0.1)
            make.leading.width.bottom.equalToSuperview()
        }
    }
}
