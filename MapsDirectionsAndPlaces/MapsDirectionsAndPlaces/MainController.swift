//
//  MainController.swift
//  MapsDirectionsAndPlaces
//
//  Created by Aleksei Danilov on 23.05.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import UIKit
import Combine
import MapKit
import LBTATools

final class MainController: UIViewController {
    
    private let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    
    private let searchTextField = UITextField(placeholder: "Search query")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestUserLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        mapView.fillSuperview()
        
        setupRegionForMap()
        setupAnnotationsForMap()
        performLocalSearch()
        setupSearchUI()
        setupLocationsCarousel()
    }
    
    private var textFieldListener: AnyCancellable?
    
    private lazy var locationsController: LocationsCarouselController = {
        let controller = LocationsCarouselController(scrollDirection: .horizontal)
        controller.mainController = self
        return controller
    }()
    
    private func setupLocationsCarousel() {
        
        let locationsView = locationsController.view!
        
        view.addSubview(locationsView)
        locationsView.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            size: .init(width: 0, height: 150)
        )
    }
    
    private func setupSearchUI() {
        let whiteContainer = UIView(backgroundColor: .white)
        view.addSubview(whiteContainer)
        whiteContainer.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 50))
        
        whiteContainer.stack(searchTextField).withMargins(.allSides(16))
        
        textFieldListener = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: searchTextField)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { _ in
                self.performLocalSearch()
            }
    }
    
    private func performLocalSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTextField.text
        request.region = mapView.region
        
        let localSearch = MKLocalSearch(request: request)
        localSearch.start { response, error in
            if let error = error {
                print("Failde local search: ", error)
                return
            }
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.locationsController.items.removeAll()
            
            response?.mapItems.forEach { mapItem in
                let annotation = CustomMapItemAnnotation()
                annotation.mapItem = mapItem
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = "Location: \(mapItem.name ?? "")"
                self.mapView.addAnnotation(annotation)
                self.locationsController.items.append(mapItem)
            }
            
            if self.locationsController.items.count > 0 {
                self.locationsController.collectionView.scrollToItem(at: [0, 0], at: .centeredHorizontally, animated: true)
            }
            
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
    private func setupAnnotationsForMap() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: 37.7666,
            longitude: -122.427290
        )
        annotation.title = "San Francisco"
        annotation.subtitle = "CA"
        mapView.addAnnotation(annotation)
        
        let appleCampusAnnotation = MKPointAnnotation()
        appleCampusAnnotation.coordinate = CLLocationCoordinate2D(
            latitude: 37.3326,
            longitude: -122.030024
        )
        appleCampusAnnotation.title = "Apple Campus"
        appleCampusAnnotation.subtitle = "Cupertino, CA"
        mapView.addAnnotation(appleCampusAnnotation)
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    private func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(
            latitude: 37.7666,
            longitude: -122.427290
        )
        let span = MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1
        )
        let region = MKCoordinateRegion(
            center: centerCoordinate,
            span: span
        )
        mapView.setRegion(region, animated: true)
    }
    
    private func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
}

import SwiftUI

struct MainPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        typealias UIViewControllerType = MainController
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> MainController {
            return MainController()
        }
        
        func updateUIViewController(_ uiViewController: MainController, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            
        }
    }
}

extension MainController: MKMapViewDelegate {
    
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let annotationView = MKPinAnnotationView(
                annotation: annotation,
                reuseIdentifier: "id"
            )
            annotationView.canShowCallout = true
            return annotationView
        }
        return nil
    }
    
    func mapView(
        _ mapView: MKMapView,
        didSelect view: MKAnnotationView
    ) {
        guard let customAnnotation = view.annotation as? CustomMapItemAnnotation else { return }
        guard let index = locationsController.items.firstIndex(where: { $0.name ==  customAnnotation.mapItem?.name }) else {
            return
        }
        locationsController.collectionView.scrollToItem(
            at: [0, index],
            at: .centeredHorizontally,
            animated: true
        )
    }
}

extension MainController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let firstLocation = locations.first else { return }
        mapView.setRegion(.init(
            center: firstLocation.coordinate,
            span: .init(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1
            )), animated: false
        )
    }
}
