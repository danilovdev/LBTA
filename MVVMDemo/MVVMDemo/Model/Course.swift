//
//  Course.swift
//  MVVMDemo
//
//  Created by Alexey Danilov on 05/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import Foundation

struct Course: Decodable {
    
    let id: Int
    
    let name: String
    
    let number_of_lessons: Int
}
