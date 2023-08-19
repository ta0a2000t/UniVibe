//
//  MainTabView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct MainTabView: View {
    let currentUser: User
    @Environment(\.colorScheme) var colorScheme
    //@EnvironmentObject private var viewModel: UserViewModel
    @State var idx = 0
    
    @State private var featchedUser: User? = nil

    
    var body: some View {
        VStack{
            
            

            VStack {
                Text("User Details")
                    .font(.title)
                
                if let user = featchedUser {
                    Text("Username: \(user.username)")
                    Text("fullname: \(user.fullname)")
                    // ... other user details
                } else {
                    Text("Loading user data...")
                        .onAppear {
                            UserViewModel.fetchByID(id: "abcuser") { fetchedUser in
                                self.featchedUser = fetchedUser
                            }
                        }
                }
            }
            

            
            
            Button {
                //UserViewModel.addToDB(user: User.MOCK_USERS[idx])


                idx += 1
            } label: {
                Text("abc")
                
            }
            TabView {
                HomeView(currentUser: currentUser).tabItem() {
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
