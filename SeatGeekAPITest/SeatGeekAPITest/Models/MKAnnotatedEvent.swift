//
//  MKAnnotatedEvent.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/20/21.
//

import MapKit

class MKEvent: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(event: Event) {
        self.title = event.venue.name
        self.subtitle = ""
        self.coordinate = CLLocationCoordinate2D(latitude: event.venue.location.lat, longitude: event.venue.location.lon)
    }
}
