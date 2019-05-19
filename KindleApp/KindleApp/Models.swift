//
//  Models.swift
//  KindleApp
//
//  Created by Alexey Danilov on 5/18/19.
//  Copyright © 2019 EDEN. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    let title: String
    
    let author: String
    
    let pages: [Page]
    
    let image: UIImage
    
    init(title: String, author: String, image: UIImage, pages: [Page]) {
        self.title = title
        self.author = author
        self.image = image
        self.pages = pages
    }
}

class Page {
    
    let number: Int
    
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
