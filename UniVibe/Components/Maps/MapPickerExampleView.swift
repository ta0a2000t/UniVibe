
//  UsageExample.swift
//
//
//  Created by Alessio Rubicini on 13/08/21.
//

import Foundation
import SwiftUI
import MapKit
import LocationPicker

struct UsageExample: View {
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)
    @State private var showSheet = false
    @State private var isLocationSelected = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Location")) {
                    Text("\(coordinates.latitude), \(coordinates.longitude)")
                    Button("Select location") {
                        self.showSheet.toggle()
                    }
                }
                
                if isLocationSelected {
                    Section(header: Text("Selected Location")) {
                        MapWithPinView(coordinates: $coordinates)
                            .frame(height: 200)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                    }
                }
                    
            }
            .navigationTitle("LocationPicker")
            
            .sheet(isPresented: $showSheet) {
                NavigationView {
                    LocationPicker(instructions: "Tap somewhere to select your coordinates", coordinates: $coordinates)
                        .navigationTitle("Location Picker")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: Button(action: {
                            self.showSheet.toggle()
                            self.isLocationSelected = true
                        }, label: {
                            Text("Close").foregroundColor(.red)
                        }))
                }
            }
        }
    }
}

struct UsageExample_Previews: PreviewProvider {
    static var previews: some View {
        UsageExample()
    }
}
