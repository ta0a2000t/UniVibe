//
//  CampusMapView.swift
//  UniVibe
//
//  Created by Taha Al on 8/17/23.
//

// https://holyswift.app/new-mapkit-configurations-with-swiftui/

import SwiftUI
import MapKit

final class MapSettings: ObservableObject {
    static let SPAN_SIZE = 0.01
    static let lon =  -76.94251
    static let lat = 38.9860
    @Published var mapType = 0
    @Published var showEmphasisStyle = 0
    
    @Published var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: MapSettings.lat , longitude: MapSettings.lon), span: MKCoordinateSpan(latitudeDelta: MapSettings.SPAN_SIZE, longitudeDelta: MapSettings.SPAN_SIZE))
    
    
    func resetRegion() {
        self.coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: MapSettings.lat , longitude: MapSettings.lon), span: MKCoordinateSpan(latitudeDelta: MapSettings.SPAN_SIZE, longitudeDelta: MapSettings.SPAN_SIZE))
    }
}



import SwiftUI
import MapKit
import Combine

struct CampusMapView: View {
    @ObservedObject var mapSettings = MapSettings()
    @State var mapType = 0
    @State var selectedEvent: Event?

    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(events: Event.MOCK) { selectedEventFromPin in
                        // Handle the selected event here
                        
                        print("selectedEventFromPin: \(selectedEventFromPin.title)")
                        selectedEvent = selectedEventFromPin
    
                        
                        
            }
                    .edgesIgnoringSafeArea(.horizontal)
                    .edgesIgnoringSafeArea(.top)
                    .padding(.bottom, 20)
                    .environmentObject(mapSettings)
                    
                    
                    Button(action: {
                        mapSettings.resetRegion()
                    }) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 25, weight: .bold)).shadow(radius: 4).foregroundColor(.white) // Set the font and size
                    }.padding()
                    .cornerRadius(15) // Apply corner radius for a rounded look
                    .shadow(radius: 7).buttonStyle(GrowingButton(enabledColor: .purple))// Add a shadow for a raised appearance
                    .background(Color.clear) // Add transparent background
                    .frame(width: 60, height: 60) // Increase hit area
                    
                    
                }/*.overlay(alignment: .top) {
                    
                    VStack {
                        Picker("Map Type", selection: $mapType) {
                            Text("Standard").tag(0)
                            Text("Image").tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                            .onChange(of: mapType) { newValue in
                                mapSettings.mapType = newValue
                            }.padding([.top, .leading, .trailing], 16)
                    }
                }*/.sheet(item: $selectedEvent) { event in
                    NavigationView{EventProfileView(event: event, isCurrentUserAttending: CurrentUserViewModel.shared.isAttending(event: event))}
                }.linearGradientBackground()
    }
}



struct MapView: UIViewRepresentable {
    
    let events: [Event]
    var didSelect: (Event) -> ()  // Callback for selecting an event

    @EnvironmentObject private var mapSettings: MapSettings

    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        //updateMapType(uiView)
        
        uiView.setRegion(mapSettings.coordinateRegion, animated: true)
        

        // Add annotations for events
        uiView.removeAnnotations(uiView.annotations)
        let annotations = events.map { event -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            annotation.title = event.title
            return annotation
        }
        uiView.addAnnotations(annotations)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else {
                return nil
            }
            
            let identifier = "EventAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        // Handle annotation accessory button tap
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let annotation = view.annotation as? MKPointAnnotation else { return }
            
            if let event = parent.events.first(where: { event in
                return event.latitude == annotation.coordinate.latitude &&
                    event.longitude == annotation.coordinate.longitude
            }) {
                parent.didSelect(event)
            }
            
            
        }
        
        
        
        
        
    }
    
    
    


    
    private func updateMapType(_ uiView: MKMapView) {
        switch mapSettings.mapType {
            
        case 0:
            uiView.preferredConfiguration = MKStandardMapConfiguration( emphasisStyle: emphasisStyle())
             
        case 1:
             
            uiView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: elevationStyle())
        default:
            break
        }
        
    }
    
    private func elevationStyle() -> MKMapConfiguration.ElevationStyle {
            return MKMapConfiguration.ElevationStyle.flat
    }
    
    private func emphasisStyle() -> MKStandardMapConfiguration.EmphasisStyle {

        if mapSettings.showEmphasisStyle == 0 {
            return MKStandardMapConfiguration.EmphasisStyle.default
        } else {
            return MKStandardMapConfiguration.EmphasisStyle.muted
        }
    }

    
}




struct CampusMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView()
    }
}
