//
//  CustomColoredButton.swift
//  Booking-Hotel
//
//  Created by Alisher on 17.01.2024.
//

import Foundation
import UIKit

enum Color {
    case blue, yellow
    
    func getTitleColor() -> UIColor { (self == .blue) ? UIColor(rgb: 0x0D72FF) : UIColor(rgb: 0xFFA800) }
    func getBackgroundColor() -> UIColor { (self == .blue) ? UIColor(rgb: 0x0D72FF, alpha: 0.1) : UIColor(rgb: 0xFFC700, alpha: 0.2) }
}

class CustomColoredButton: UIButton {
    var color: Color = .blue
    var rightSideImage = false
    var title: String = ""
    
    init(frame: CGRect, color: Color, rightSideImage: Bool = false, title: String) {
        self.color = color
        self.rightSideImage = rightSideImage
        self.title = title
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if rightSideImage {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleLabel!.frame.width, bottom: 0, right: -titleLabel!.frame.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageView!.frame.width, bottom: 0, right: imageView!.frame.width)
        }
    }
    
    private func commonInit() {
        setTitleColor(color.getTitleColor(), for: .normal)
        tintColor = UIColor(rgb: 0x0D72FF)
        backgroundColor = color.getBackgroundColor()
        layer.cornerRadius = 5
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        isEnabled = false
        
        let attributes: [NSAttributedString.Key: Any] = [ .font: Constant.defaultFont ]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedText, for: .normal)
    }
    
}
