//
//  UIViewExtensions.swift
//  YouTubeApp
//
//  Created by Alexey Danilov on 05/09/2018.
//  Copyright © 2018 Alexey Danilov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: format,
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: viewsDictionary))
    }
}
