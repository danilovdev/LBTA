//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Alexey Danilov on 05/09/2018.
//  Copyright © 2018 Alexey Danilov. All rights reserved.
//

import Foundation
import UIKit

class VideoCell: BaseCell {
    
    private var titleLabelHeightConstraint: NSLayoutConstraint?
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) ● \(numberFormatter.string(from:  numberOfViews)!) ● 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(
                    with: size,
                    options: options,
                    attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)],
                    context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
            
        }
    }
    
    private func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    private func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    private let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    private let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO ● 1,604,684,607 views ● 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        
        
        addConstraint(NSLayoutConstraint(
            item: titleLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: userProfileImageView,
            attribute: .right,
            multiplier: 1,
            constant: 8))
        addConstraint(NSLayoutConstraint(
            item: titleLabel,
            attribute: .right,
            relatedBy: .equal,
            toItem: thumbnailImageView,
            attribute: .right,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: thumbnailImageView,
            attribute: .bottom,
            multiplier: 1,
            constant: 8))
        
        titleLabelHeightConstraint = NSLayoutConstraint(
            item: titleLabel,
            attribute: .height,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 0,
            constant: 44)
        
        addConstraint(titleLabelHeightConstraint!)
        
        addConstraint(NSLayoutConstraint(
            item: subtitleTextView,
            attribute: .left,
            relatedBy: .equal,
            toItem: userProfileImageView,
            attribute: .right,
            multiplier: 1,
            constant: 8))
        addConstraint(NSLayoutConstraint(
            item: subtitleTextView,
            attribute: .right,
            relatedBy: .equal,
            toItem: thumbnailImageView,
            attribute: .right,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: subtitleTextView,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 4))
        addConstraint(NSLayoutConstraint(
            item: subtitleTextView,
            attribute: .height,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 0,
            constant: 30))
    }
}
