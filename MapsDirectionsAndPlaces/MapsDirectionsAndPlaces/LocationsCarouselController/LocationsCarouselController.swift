//
//  LocationsCarouselController.swift
//  MapsDirectionsAndPlaces
//
//  Created by Aleksei Danilov on 23.05.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import Foundation
import UIKit
import LBTATools
import MapKit

final class LocationsCarouselController: LBTAListController<LocationsCarouselCell, MKMapItem> {
    
    weak var mainController: MainController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let annotations = mainController?.mapView.annotations
        annotations?.forEach { annotation in
            guard let customAnnotation = annotation as? CustomMapItemAnnotation else { return }
            if customAnnotation.mapItem?.name == self.items[indexPath.item].name {
                mainController?.mapView.selectAnnotation(annotation, animated: true)
            }
        }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension LocationsCarouselController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: view.frame.width - 64, height: view.frame.height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 12
    }
}
