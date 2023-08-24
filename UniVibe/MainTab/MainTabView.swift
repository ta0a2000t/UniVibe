//
//  MainTabView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var currentUserViewModel = CurrentUserViewModel.shared
    @State private var selection = 3

    
    @State private var tabSelection = 1
    @State private var tappedTwice: Bool = false

    @State private var home = UUID()
    
    var body: some View {
        var handler: Binding<Int> { Binding(
                get: { self.tabSelection },
                set: {
                    if $0 == self.tabSelection {
                        // Lands here if user tapped more than once
                        tappedTwice = true
                    }
                    self.tabSelection = $0
                }
        )}

        return TabView(selection:$selection) {
            
            
            NavigationView{
                HomeView().id(home)
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                        self.tappedTwice = false
                    })
            }.tabItem() {
                Label("Home", systemImage: "house")
            }.tag(1).environmentObject(currentUserViewModel)
            
            NavigationView {
                ExploreView().id(home)
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                        self.tappedTwice = false
                    })
            }.tabItem() {
                Label("Search", systemImage: "magnifyingglass")
            }.tag(2).environmentObject(currentUserViewModel)
            NavigationView {
                CampusMapView().id(home)
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                        self.tappedTwice = false
                    })
            }.tabItem() {
                Label("Map", systemImage: "map")
                
            }.tag(3)
            
            NavigationView {
                FeedView().id(home)
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                        self.tappedTwice = false
                    })
            }.tabItem() {
                Label("Feed", systemImage: "newspaper")

            }.tag(4).environmentObject(currentUserViewModel)
            
            NavigationView {
                ChatView().id(home)
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                        self.tappedTwice = false
                    })
            }.tabItem() {
                Label("Chat", systemImage: "envelope")
            }.tag(5).environmentObject(currentUserViewModel)
            
        }.tint(colorScheme == .dark ? Color.white : Color.black)
    

    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
