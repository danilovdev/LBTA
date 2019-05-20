//
//  Models.swift
//  KindleApp
//
//  Created by Alexey Danilov on 5/18/19.
//  Copyright © 2019 EDEN. All rights reserved.
//

class Page {
    
    let number: Int
    
    let text: String
    
    init(dictionary: [String: Any]) {
        let pageText = dictionary["text"] as? String ?? ""
        number = 1
        text = pageText
    }
}
