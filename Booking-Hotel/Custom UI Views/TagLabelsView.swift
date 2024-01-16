//
//  TagLabelsView.swift
//  Booking-Hotel
//
//  Created by Alisher on 16.01.2024.
//

import Foundation
import UIKit

class TagLabelsView: UIView {
    
    var tagNames: [String] = [] {
        didSet {
            addTagLabels()
        }
    }
    
    let tagHeight:CGFloat = 30
    let tagPadding: CGFloat = 16
    let tagSpacingX: CGFloat = 8
    let tagSpacingY: CGFloat = 8

    var intrinsicHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() -> Void {
    }

    func addTagLabels() -> Void {
        
        while self.subviews.count > tagNames.count {
            self.subviews[0].removeFromSuperview()
        }
        
        while self.subviews.count < tagNames.count {
            let newLabel = UILabel()
            newLabel.textAlignment = .center
            newLabel.backgroundColor = UIColor(rgb: 0xFBFBFC)
            newLabel.layer.masksToBounds = true
            newLabel.layer.cornerRadius = 5
            newLabel.textColor = UIColor(rgb: 0x828796)
            addSubview(newLabel)
        }
        
        for (str, v) in zip(tagNames, self.subviews) {
            guard let label = v as? UILabel else {
                fatalError("non-UILabel subview found!")
            }
            label.text = str
            label.frame.size.width = label.intrinsicContentSize.width + tagPadding
            label.frame.size.height = tagHeight
        }

    }
    
    func displayTagLabels() {
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0

        self.subviews.forEach { v in
            
            guard let label = v as? UILabel else {
                fatalError("non-UILabel subview found!")
            }
        
            if currentOriginX + label.frame.width > Constant.systemWidth - 32 {
                currentOriginX = 0
                currentOriginY += tagHeight + tagSpacingY
            }
            
            label.frame.origin.x = currentOriginX
            label.frame.origin.y = currentOriginY
            
            currentOriginX += label.frame.width + tagSpacingX
            
        }
        
        intrinsicHeight = currentOriginY + tagHeight
        invalidateIntrinsicContentSize()
        
    }

    override var intrinsicContentSize: CGSize {
        var sz = super.intrinsicContentSize
        sz.height = intrinsicHeight
        return sz
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayTagLabels()
    }
    
}
