//
//  MapView.swift
//  UniVibe
//
//  Created by Taha Al on 8/22/23.
//
import SwiftUI
import MapKit

struct EquatableCoordinate: Equatable {
    let latitude: Double
    let longitude: Double
    
    static func == (lhs: EquatableCoordinate, rhs: EquatableCoordinate) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}

struct MapWithPinView: View {
    @Binding var coordinates: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion
    
    init(coordinates: Binding<CLLocationCoordinate2D>) {
        _coordinates = coordinates
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinates.wrappedValue,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: false, userTrackingMode: .none, annotationItems: [PinItem(coordinate: coordinates)]) { item in
            MapMarker(coordinate: item.coordinate, tint: .blue)
        }
        .edgesIgnoringSafeArea(.all)
        .onChange(of: EquatableCoordinate(coordinates)) { _ in
            region.center = coordinates
        }
    }
}

struct PinItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapWithPinView_Previews: PreviewProvider {
    static var previews: some View {
        MapWithPinView(coordinates: .constant(CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))) // Replace with your coordinates
    }
}
