//
//  LocationsCarouselCell.swift
//  MapsDirectionsAndPlaces
//
//  Created by Aleksei Danilov on 23.05.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import Foundation
import UIKit
import LBTATools
import MapKit

final class LocationsCarouselCell: LBTAListCell<MKMapItem> {
    
    override var item: MKMapItem! {
        didSet {
            locationLabel.text = item.name
            addressLabel.text = item.address
        }
    }
    
    private let locationLabel = UILabel(text: "Location", font: .boldSystemFont(ofSize: 16))
    
    private let addressLabel = UILabel(text: "Address", numberOfLines: 0)
    
    override func setupViews() {
        backgroundColor = .white
        
        setupShadow(opacity: 0.2, radius: 5, offset: .zero, color: .black)
        layer.cornerRadius = 5
        clipsToBounds = false
        
        stack(locationLabel, addressLabel).withMargins(.allSides(16))
    }
}
