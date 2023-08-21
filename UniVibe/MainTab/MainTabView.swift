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

    init(currentUser: User) {
        self.currentUserViewModel = CurrentUserViewModel(currentUser: currentUser)
    }
    

    var body: some View {
        VStack{
            
            TabView {
                HomeView().environmentObject(currentUserViewModel).tabItem() {
                    Image(systemName: "house").foregroundColor(.white)
                }
                
                ExploreView().tabItem() {
                    Image(systemName: "magnifyingglass").foregroundColor(.white)
                }.environmentObject(currentUserViewModel)
                
                CampusMapView().tabItem() {
                    Image(systemName: "map").foregroundColor(.white)
                }
                
                FeedView().tabItem() {
                    Image(systemName: "newspaper").foregroundColor(.white)
                }.environmentObject(currentUserViewModel)
                
                ChatView().tabItem() {
                    Image(systemName: "envelope").foregroundColor(.white)
                }.environmentObject(currentUserViewModel)
                
            }.tint(colorScheme == .dark ? Color.white : Color.black)
        }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(currentUser: User.MOCK_USERS[0])
    }
}
