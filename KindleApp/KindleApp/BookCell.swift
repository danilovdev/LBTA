//
//  BookCell.swift
//  KindleApp
//
//  Created by Alexey Danilov on 5/18/19.
//  Copyright © 2019 EDEN. All rights reserved.
//

import Foundation
import UIKit

class BookCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            coverImageView.image = book?.image
            titleLabel.text = book?.title
            authorLabel.text = book?.author
        }
    }
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the text for the title of our book inside of our cell"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "This is some author for the book that we have in this row"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .yellow
        
        addSubview(coverImageView)
        coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        
        addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
