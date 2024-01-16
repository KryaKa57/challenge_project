//
//  CarouselCell.swift
//  Booking-Hotel
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit
import SnapKit

class CarouselCell: UICollectionViewCell {

    static let reuseIdentifier = "CarouselCell"

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }

    func configure(with imageUrl: String) {
        imageView.loadImage(from: imageUrl)
    }
}
