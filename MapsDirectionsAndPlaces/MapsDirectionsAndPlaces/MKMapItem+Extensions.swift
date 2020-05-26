//
//  MKMapItem+Extensions.swift
//  MapsDirectionsAndPlaces
//
//  Created by Aleksei Danilov on 23.05.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import Foundation
import MapKit

extension MKMapItem {
    var address: String {
        var addressString = ""
        if placemark.subThoroughfare != nil {
            addressString = placemark.subThoroughfare! + " "
        }
        if placemark.thoroughfare != nil {
            addressString += placemark.thoroughfare! + ", "
        }
        if placemark.postalCode != nil {
            addressString += placemark.postalCode! + " "
        }
        if placemark.locality != nil {
            addressString += placemark.locality! + ", "
        }
        if placemark.administrativeArea != nil {
            addressString += placemark.administrativeArea! + " "
        }
        if placemark.country != nil {
            addressString += placemark.country!
        }
        return addressString
    }
}
