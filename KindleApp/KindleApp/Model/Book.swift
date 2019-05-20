//
//  Book.swift
//  KindleApp
//
//  Created by Alexey Danilov on 5/20/19.
//  Copyright © 2019 EDEN. All rights reserved.
//

class Book {
    
    let title: String
    
    let author: String
    
    let pages: [Page]
    
    let coverImageUrl: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? ""
        author = dictionary["author"] as? String ?? ""
        coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
        
        var bookPages = [Page]()
        if let pagesDictionaries = dictionary["pages"] as? [[String: Any]] {
            for pageDictionary in pagesDictionaries {
                let bookPage = Page(dictionary: pageDictionary)
                bookPages.append(bookPage)
            }
        }
        pages = bookPages
    }
}
