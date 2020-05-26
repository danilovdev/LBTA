//
//  Service.swift
//  AppStoreJSONApis
//
//  Created by Aleksei Danilov on 25.04.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    private init() { }
    
    func fetchResults(completion: @escaping ([Result], Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion([], error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                let searchResult = try jsonDecoder.decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
                
            } catch let jsonError {
//                print("Failed to decode json: ", jsonError)
                completion([], jsonError)
            }
            
        }.resume()
    }
}
