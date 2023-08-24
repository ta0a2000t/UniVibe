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
        NavigationStack{
            
            TabView(selection: $selection) {
                HomeView().tabItem() {
                    Label("Home", systemImage: "house").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
                }.tag(1)
                
                ExploreView().tabItem() {
                    Label("Search", systemImage: "magnifyingglass").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
                }.tag(2)
                
                CampusMapView().tabItem() {
                    Label("Map", systemImage: "map").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
                }.tag(3)
                
                FeedView().tabItem() {
                    Label("Feed", systemImage: "newspaper").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
                }.tag(4)
                
                ChatView().tabItem() {
                    Label("Chat", systemImage: "envelope").foregroundColor(ColorUtilities.dynamicForgroundColor(for: colorScheme))
                }.tag(4)
                
            }.tint(colorScheme == .dark ? Color.white : Color.black)
        }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
