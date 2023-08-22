//
//  MainTabView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var currentUserViewModel : CurrentUserViewModel
    @State private var selection = 3

    init(currentUser: User) {
        self.currentUserViewModel = CurrentUserViewModel(currentUser: currentUser)
    }
    

    var body: some View {
        ZStack {
            
            
            VStack{
                
                TabView(selection:$selection) {
                    HomeView().environmentObject(currentUserViewModel).tabItem() {
                        
                        Label("Home", systemImage: "house")
                    }.tag(1)
                    
                    ExploreView().tabItem() {
                        Label("Search", systemImage: "magnifyingglass")
                        

                    }.tag(2).environmentObject(currentUserViewModel)
                    
                    CampusMapView().tabItem() {
                        Label("Map", systemImage: "map")
                        
                    }.tag(3)
                    
                    FeedView().tabItem() {
                        Label("Feed", systemImage: "newspaper")

                    }.tag(4).environmentObject(currentUserViewModel)
                    
                    ChatView().tabItem() {
                        Label("Chat", systemImage: "envelope")

                    }.tag(5).environmentObject(currentUserViewModel)
                    
                }.tint(colorScheme == .dark ? Color.white : Color.black)
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(currentUser: User.MOCK_USERS[0])
    }
}
