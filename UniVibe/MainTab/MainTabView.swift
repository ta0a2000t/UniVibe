//
//  MainTabView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct MainTabView: View {
    let currentUser: User
    var body: some View {
        TabView {
            HomeView(currentUser: currentUser).tabItem() {
                Image(systemName: "house").foregroundColor(.white)
                //Text("Record")
            }
            
            ExploreView().tabItem() {
                Image(systemName: "magnifyingglass").foregroundColor(.white)
            }
            
            // acts like a notifications view
            FeedView().tabItem() {
                Image(systemName: "newspaper").foregroundColor(.white)
            }
            

            ChatView().tabItem() {
                Image(systemName: "envelope").foregroundColor(.white)
                //Text("Record")
            }
            
        }.tint(.black)
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(currentUser: User.MOCK_USERS[0])
    }
}
