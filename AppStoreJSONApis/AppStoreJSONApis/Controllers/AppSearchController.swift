//
//  AppSearchController.swift
//  AppStoreJSONApis
//
//  Created by Aleksei Danilov on 22.04.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import UIKit

class AppSearchController: UICollectionViewController {
    
    private let cellId = "CellId"
    
    private var appResults = [Result]()
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchItunesApps()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return appResults.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        
        let appResult = appResults[indexPath.item]
        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
        
        return cell
    }
    
    
    
    private func fetchItunesApps() {
        Service.shared.fetchResults { [weak self] results, error in
            if let error = error {
                print("Failed to fetch apps: ", error)
                return
            }
            
            self?.appResults = results
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension AppSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}
