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
    
    private let locations : [NationalParkLocation] = Bundle.main.decode("locations.json")
    
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
            
            // (C) - Custom Basic (it could be interactive)
            // MapAnnotation(coordinate: annotation.location) {
            //     Image("logo")
            //         .resizable()
            //         .scaledToFit()
            //         .frame(width: 32, height: 32, alignment: .center)
            // }  //: ANNOTATION
            
            // (D) - Custom Advanced Annotation (it could be interactive)
            MapAnnotation(coordinate: annotation.location) {
                MapAnnotationView(location: annotation)
            }
        } //: MAP
        .overlay(
            HStack(alignment: .center, spacing: 12) {
                Image("compass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text("Latitude")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.latitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Longtitude")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.longitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    
                } //: VSTACK
                
                
            } //: HSTACK
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    Color.black
                        .cornerRadius(8)
                        .opacity(0.6)
                )
                .padding()
            , alignment: .top
        )
    }
}


// MARK: - PREVIEW
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
