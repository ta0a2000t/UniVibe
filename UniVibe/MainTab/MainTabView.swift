//
//  MainTabView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme
    //@EnvironmentObject private var viewModel: UserViewModel

    //@State private var fetchedUser: User? = nil

    @StateObject var profileViewModel: ProfileViewModel

    init(currentUser: User) {
        self._profileViewModel = StateObject(wrappedValue: ProfileViewModel(currentUser: currentUser))
    }

    var body: some View {
        VStack{
            
            
            /*
            VStack {
                Text("User Details")
                    .font(.title)
                
                if let user = fetchedUser {
                    Text("Username: \(user.username)")
                    Text("fullname: \(user.fullname)")
                    // ... other user details
                } else {
                    Text("Loading user data...")
                        .task {
                            self.fetchedUser = await UserDataModel.fetchByID(id: "abcuser")
                        }
                }
            }
             */
            
            TabView {
                HomeView().environmentObject(profileViewModel).tabItem() {
                    Image(systemName: "house").foregroundColor(.white)
                    //Text("Record")
                }
                
                ExploreView().tabItem() {
                    Image(systemName: "magnifyingglass").foregroundColor(.white)
                }
                
                CampusMapView().tabItem() {
                    Image(systemName: "map").foregroundColor(.white)
                }
                
                // acts like a notifications view
                FeedView().tabItem() {
                    Image(systemName: "newspaper").foregroundColor(.white)
                }
                
                
                ChatView().tabItem() {
                    Image(systemName: "envelope").foregroundColor(.white)
                    //Text("Record")
                }
                
            }.tint(colorScheme == .dark ? Color.white : Color.black)
        }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(currentUser: User.MOCK_USERS[0])
    }
}
