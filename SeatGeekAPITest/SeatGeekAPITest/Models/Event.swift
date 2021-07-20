//
//  Event.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/16/21.
//

import UIKit

struct Events: Decodable {
    let events: [Event]
    
    enum CodingKeys: String, CodingKey {
        case events
    }
}

struct Event: Decodable {
    
    let type: String
    let id: Int
    let date: String
    let venue: Venue
    let title: String
    let performers: [Performer]
    
    enum CodingKeys: String, CodingKey {
        case date = "datetime_utc"
        case title = "short_title"
        case type
        case id
        case venue
        case performers
    }
    
    struct Performer: Decodable {
        let image: String
    }
    
    struct Venue: Decodable {
        
        let displayLocation: String
        let name: String
        let location: Location
        let capacity: Int
        let venueId: Int
        
        enum CodingKeys: String, CodingKey {
            case displayLocation = "display_location"
            case name
            case location
            case capacity
            case venueId = "id"
        }
        
        struct Location: Decodable {
            let lat: Double
            let lon: Double
        }
    }
}




