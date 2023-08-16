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

    let currentUser: User
    @Environment (\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            VStack{
                HStack {
                    // prof pic
                    if let profileImageURL = currentUser.profileImageURL {
                        Image(profileImageURL)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .background(.gray)
                            .clipShape(Circle())
                    }
                    
                    
                    Spacer()
                    
                    HStack(spacing: 23) {
                        
                        ProfileStatView(value: 22, title: "Groups")
                        Divider().frame(height: 40)
                        ProfileStatView(value: 5, title: "Events")
                        Divider().frame(height: 40)
                        ProfileStatView(value: 5, title: "Friends")
                    }.padding(.trailing)
                }.padding(.horizontal)
                HStack {
                    VStack(alignment: .leading){
                        Text(currentUser.fullname).bold()
                        
                        if let bio = currentUser.bio {
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
                    SectionAndSelectionsView(title: "Interests", selections: ["Outdoor", "Painting", "Swimming"]).padding(.bottom)
                    
                    SectionAndSelectionsView(title: "Looking To", selections: ["Outdoor", "Painting", "Swimming"])
                    
                    VStack(alignment: .leading) {
                        Text("Communities").font(.title2).bold()
                        
                        LazyVStack(spacing:12) {
                            ForEach(Community.MOCK) { community in
                                
                                NavigationLink(destination: CommunityProfileView(community: community).navigationBarBackButtonHidden(true)) {
                                    CommunityInListView(membersCount: community.membersIDs.count, communityName: community.fullname)
                                    
                                }
                            }
                        }
                        
                        
                        
                    }.padding(.leading)
                }
                
                
                
                
                Spacer()

            }
        }.sheet(isPresented: $showEditProfile) {
            EditProfileView()
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(currentUser.username)
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
                        [.medium],
                        selection: $settingsDetent
                     )
            }
        
        
    }
}
struct CurrentUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfile(currentUser: User.MOCK_USERS[0])
    }
}
