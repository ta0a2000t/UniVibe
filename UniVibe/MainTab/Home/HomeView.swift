//
//  HomeView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel

    @State var showCreateEventView: Bool = false

    var body: some View {
        NavigationStack{
            VStack {
                VStack(alignment:.trailing) {
                    Text(" \(profileViewModel.currentUser.fullname)").font(.title3).bold().padding(.bottom)
                    
                    
                    
                    VStack {

                        Text("Reserved Events").font(.title2).bold()
                        ScrollView(.vertical) {
                            
                            
                            LazyVStack(spacing:12) {
                                
                                ForEach(profileViewModel.reservedEvents) { event in
                                    
                                    NavigationLink(destination: EventProfileView(event: event).navigationBarBackButtonHidden(true)) {
                                        EventInListView(event: event)
                                        
                                    }
                                }
                                
                            }
                        }.frame(height: 180)
                        
                        Divider()
                    }.padding(.bottom)
                    
                    
                    VStack {

                        Text("Created Events").font(.title2).bold()
                        HorizontalEventGridView(events: profileViewModel.createdEvents)
                        
                        Divider()
                    }.padding(.bottom)
                    

                    Spacer()
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: CreateEventView(creatorID: profileViewModel.currentUser.id, isCommunityEvent: false).navigationBarBackButtonHidden(true)) {
                            Text("Create Event")
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(width: 330, height:40)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 3).foregroundColor(.red)
                                )
                        }
                        Spacer()
                    }.padding()
                    
                }.padding(.horizontal)
                
                
                
                
                
                
                
                
                
                
                
            }.frame(width: UIScreen.main.bounds.width)
            .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        LogoOnTopMiddleView()
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CurrentUserProfile(currentUser: profileViewModel.currentUser).navigationBarBackButtonHidden(true)
                        } label: {
                            
                            if let profileImageURL = profileViewModel.currentUser.profileImageURL {
                                Image(profileImageURL)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                        }

                        
                        
                }
            }

            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
