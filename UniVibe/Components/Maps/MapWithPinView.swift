//
//  MapView.swift
//  UniVibe
//
//  Created by Taha Al on 8/22/23.
//
import SwiftUI
import MapKit

struct MapWithPinView: View {
    let latitude: Double
    let longitude: Double

    var body: some View {
        Map(coordinateRegion: .constant(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        ), showsUserLocation: false, userTrackingMode: .none, annotationItems: [PinItem(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))]) { item in
            MapMarker(coordinate: item.coordinate, tint: .blue)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PinItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapWithPinView_Previews: PreviewProvider {
    static var previews: some View {
        MapWithPinView(latitude: 37.7749, longitude: -122.4194) // Replace with your coordinates
    }
}
