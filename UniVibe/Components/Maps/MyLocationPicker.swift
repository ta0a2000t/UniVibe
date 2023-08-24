import SwiftUI
import MapKit

struct MyLocationPicker: View {
    @State private var showSheet = false
    @Binding var coordinates : CLLocationCoordinate2D
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {

                MapWithPinView(coordinates: $coordinates)
                
                Button {
                    self.showSheet.toggle()
                } label: {
                    HStack {
                            Image(systemName: "mappin.and.ellipse") // SF Symbol for location
                            
                                .foregroundColor(.blue)
                            Text("Select Location")
                            .font(.body)
                            .foregroundColor(.blue)
                        }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .cornerRadius(8)
                    
                }.bold().buttonStyle(GrowingButton(enabledColor: Color.green.opacity(0.4)))
                
            }
            .sheet(isPresented: $showSheet) {
                NavigationView {
                    LocationPicker3(coordinates: $coordinates)
                        .navigationBarItems(leading: Button("Done") {
                            self.showSheet = false
                        })
                        .navigationBarTitle("Pick Location", displayMode: .inline)
                }
            }
        }
    }
}



import SwiftUI
import MapKit

struct LocationPicker3: UIViewRepresentable {
    @Binding var coordinates: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Set the initial region to zoom into
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
        
        return mapView
    }


    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotation(annotation)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: LocationPicker3

        init(_ parent: LocationPicker3) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let coordinate = view.annotation?.coordinate {
                parent.coordinates = coordinate
            }
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if let coordinate = view.annotation?.coordinate {
                parent.coordinates = coordinate
            }
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
            mapView.addGestureRecognizer(tapGesture)
        }

        @objc func tap(gesture: UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            if let mapView = gesture.view as? MKMapView {
                let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                parent.coordinates = coordinate
                
                // To update annotations if you need to
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                mapView.removeAnnotations(mapView.annotations)
                mapView.addAnnotation(annotation)
            }
        }
    }
}


struct Pin: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}



struct MyLocationPicker_Previews: PreviewProvider {
    static var previews: some View {
        MyLocationPicker(coordinates: .constant(CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)))
    }
}

