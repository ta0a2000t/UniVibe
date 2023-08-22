//
//  CurrentUserProfile.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI


struct CurrentUserProfile: View {
    @State private var showEditProfile: Bool = false
    @State private var showSettings: Bool = false
    @State private var settingsDetent = PresentationDetent.medium

    @Environment (\.dismiss) var dismiss
    
    
    @EnvironmentObject var currentUserViewModel: CurrentUserViewModel

    var body: some View {
        NavigationView{
            VStack{
                HStack {
                    // prof pic
                    if let profileImageURL = currentUserViewModel.currentUser.profileImageURL {
                        Image(profileImageURL)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                    
                    
                    Spacer()
                    
                    HStack(spacing: 23) {
                        
                        ProfileStatView(value: currentUserViewModel.currentUser.communitiesIDs.count, title: "Groups")
                        Divider().frame(height: 40)
                        ProfileStatView(value: currentUserViewModel.currentUser.friendsIDs.count, title: "Friends")
                        Divider().frame(height: 40)
                        ProfileStatView(value: currentUserViewModel.getEventsCount(), title: "Events")
                    }.padding(.trailing)
                }.padding(.horizontal)
                HStack {
                    VStack(alignment: .leading){
                        Text(currentUserViewModel.currentUser.fullname).bold()
                        
                        if let bio = currentUserViewModel.currentUser.bio {
                            Text(bio)
                        }
                        
                    }.padding(.horizontal)
                    Spacer()
                }
                
                Button {
                    showEditProfile = true
                } label: {
                    Text("Edit")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(width: 330, height:40)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 3).foregroundColor(.red)
                        )
                }
                
                Divider()
                ScrollView {
                    VStack{
                        SectionAndSelectionsView(title: "Interests", selections: currentUserViewModel.currentUser.interests).padding(.bottom)
                        
                        SectionAndSelectionsView(title: "Looking To", selections: currentUserViewModel.currentUser.lookingTo)
                        
                        VStack {
                            
                            Text("Created Events").font(.title2).bold()
                            HorizontalEventGridView(events: currentUserViewModel.getCreatedEvents())//.background(.gray)
                            
                            Divider()
                        }.padding(.bottom)
                        
                        
                        VStack(alignment: .center) {
                            Text("Communities").font(.title2).bold()
                            CommunityListView(communities: Community.MOCK)
                            
                            
                            
                            
                            
                        }.padding(.horizontal)
                    }
                }
                
                
                
                
                Spacer()

            }
        }.sheet(isPresented: $showEditProfile) {
            EditProfileView()
        }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(currentUserViewModel.currentUser.username)
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "house.circle.fill").resizable()
                    }
                    
                }
                
            }.sheet(isPresented: $showSettings) {
                SettingsView()
                    .presentationDetents(
                        [.height(200)],
                        selection: $settingsDetent
                     )
            }
        
        
    }
}
struct CurrentUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        //CurrentUserProfile()
        EmptyView()
    }
}
