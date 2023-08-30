//
//  MainTabView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selection = 3

    var body: some View {
        TabView(selection: $selection) {

            NavigationView {
                HomeView()
            }.navigationViewStyle(.stack)
            .tabItem() {
                Label("Home", systemImage: "house").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme)).onTapGesture(count: 2) {
                    print("123")
                }
            }.tag(1).onTapGesture(count: 2) {
                print("432")
            }

            NavigationView {
                ExploreView()
            }.navigationViewStyle(.stack)
            .tabItem() {
                Label("Search", systemImage: "magnifyingglass").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
            }.tag(2)

            NavigationView {
                CampusMapView()
            }.navigationViewStyle(.stack)
            .tabItem() {
                Label("Map", systemImage: "map").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
            }.tag(3)

            NavigationView {
                FeedView()
            }.navigationViewStyle(.stack)
            .tabItem() {
                Label("Feed", systemImage: "newspaper").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
            }.tag(4)

            NavigationView {
                ChatView()
            }.navigationViewStyle(.stack)
            .tabItem() {
                Label("Chat", systemImage: "envelope").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
            }.tag(5)  // Note: I changed the tag to 5 as previously both Chat and Feed had the same tag 4

        }
        .tint(colorScheme == .dark ? Color.white : Color.black)
    }

}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}



