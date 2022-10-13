//
//  Location.swift
//  Africa
//
//  Created by iMamad on 13.10.22.
//

import MapKit

struct NationalParktLocation: Codable, Identifiable {
    let id : String
    let name : String
    let image: String
    let latitude: Double
    let longitude: Double
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude,
                               longitude: longitude)
    }
}
