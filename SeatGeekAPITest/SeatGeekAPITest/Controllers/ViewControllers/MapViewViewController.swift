//
//  MapViewViewController.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/20/21.
//

import UIKit
import MapKit

class MapViewViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    var event: Event?
    
    func setupViews() {
        guard let event = event else { return }
        let location = CLLocation(latitude: event.venue.location.lat, longitude: event.venue.location.lon)
        mapView.centerToLocation(location)
        
        let annotationLocation = MKEvent(event: event)
        mapView.addAnnotation(annotationLocation)
    }
}

private extension MKMapView {
    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
