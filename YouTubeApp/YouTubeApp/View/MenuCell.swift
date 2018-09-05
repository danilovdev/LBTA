//
//  MenuCell.swift
//  YouTubeApp
//
//  Created by Alexey Danilov on 05/09/2018.
//  Copyright © 2018 Alexey Danilov. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        return iv
    }()
    
    override func setupViews() {
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0))
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        }
    }
    
}
