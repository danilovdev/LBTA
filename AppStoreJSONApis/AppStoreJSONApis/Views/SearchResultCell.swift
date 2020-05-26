//
//  SearchResultCell.swift
//  AppStoreJSONApis
//
//  Created by Aleksei Danilov on 22.04.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    // MARK: - UI Components
     lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 12
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()
    
    lazy var ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    private lazy var labelsStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [
            nameLabel,
            categoryLabel,
            ratingsLabel
        ])
        return stackView
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var topHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            labelsStackView,
            getButton
        ])
        stackView.spacing = 12
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var screenshot1ImageView = createScreenshotImageView()
    
    private lazy var screenshot2ImageView = createScreenshotImageView()
    
    private lazy var screenshot3ImageView = createScreenshotImageView()
    
    private lazy var screenshotsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            screenshot1ImageView,
            screenshot2ImageView,
            screenshot3ImageView
        ])
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var mainVerticalStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [
            topHorizontalStackView,
            screenshotsStackView
        ], spacing: 16)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(mainVerticalStackView)
        mainVerticalStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createScreenshotImageView() -> UIImageView {
        let imageView =  UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }
}
