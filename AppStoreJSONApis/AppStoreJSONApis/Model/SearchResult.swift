//
//  SearchResult.swift
//  AppStoreJSONApis
//
//  Created by Aleksei Danilov on 25.04.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
}
