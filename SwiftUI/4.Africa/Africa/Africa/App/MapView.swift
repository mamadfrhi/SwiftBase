//
//  MapView.swift
//  Africa
//
//  Created by iMamad on 07.10.22.
//

import SwiftUI
import MapKit

struct MapView: View {
    //MARK: - PROPERTIES
    
    @State private var region : MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286,
                                                    longitude: 16.4377599)
        let mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70,
                                            longitudeDelta: 70)
        let mapRegion = MKCoordinateRegion(center: mapCoordinates,
                                           span: mapZoomLevel)
        return mapRegion
    }()
    
    let locations : [NationalParktLocation] = Bundle.main.decode("locations.json")
    
    //MARK: - BODY
    
    var body: some View {
        // MARK: - No1 BASIC MAP
//        Map(coordinateRegion: $region)
        
        // MARK: - No2 ADVANCE MAP
        Map(coordinateRegion: $region, annotationItems: locations) { annotation in
            // (A) - Old Style (Always Static)
            // MapPin(coordinate: annotation.location, tint: .accentColor)
            
            // (B) - New Style (Always Static)
            // MapMarker(coordinate: annotation.location, tint: .accentColor)
            
            // (B) - Custom Basic (it could be interactive)
            MapAnnotation(coordinate: annotation.location) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32, alignment: .center)
            }  //: ANNOTATION
            
        }
    }
}


// MARK: - PREVIEW
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
