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
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 5
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        return cell
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
