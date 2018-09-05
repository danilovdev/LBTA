//
//  CourseViewModel.swift
//  MVVMDemo
//
//  Created by Alexey Danilov on 05/07/2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import Foundation

struct CourseViewModel {
    
    let name: String
    
    init(course: Course) {
        self.name = course.name
    }
}
