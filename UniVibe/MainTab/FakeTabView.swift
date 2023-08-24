//
//  FakeTabView.swift
//  UniVibe
//
//  Created by Taha Al on 8/24/23.
//

import SwiftUI

struct FakeTabView: View {
    @State private var selection: Int = 0
    @State private var isActive: Bool = false
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                NavigationLink(
                    destination: Text("Detail View"),
                    isActive: $isActive,
                    label: {
                        Text("Go to Detail")
                    })
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)
            .onTapGesture(count: 2, perform: {
                self.isActive = false  // Reset the NavigationLink
            })
            
            Text("Second Tab")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            .tag(1)
        }
    }
}

struct RootView: View {
    @Binding var showDetailView: Bool
    var body: some View {
        Button("Go to Detail") {
            showDetailView = true
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
    }
}


struct FakeTabView_Previews: PreviewProvider {
    static var previews: some View {
        FakeTabView()
    }
}
