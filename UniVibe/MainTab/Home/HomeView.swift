//
//  HomeView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var currentUserViewModel: CurrentUserViewModel
    
    @State var showCreateEventView: Bool = false
    
    
    var body: some View {
        //NavigationView{
            VStack {
                VStack(alignment:.trailing) {
                    Text(" \(currentUserViewModel.user.fullname)").font(.title3).bold().padding(.bottom)
                    
                    
                    
                    
                    VStack {

                        Text("Reserved Events").font(.title2).bold()
                        
                        ScrollView{
                            EventListView(events: CurrentUserViewModel.shared.getReservedEvents())
                        }.frame(maxHeight: 200)
                    }.padding(.bottom)
                    
                    
                    VStack {
                        Text("Created Events").font(.title2).bold()
                        HorizontalEventGridView(events: CurrentUserViewModel.shared.getCreatedEvents())
                        
                        Divider()
                    }.padding(.bottom)
                    

                    Spacer()
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: CreateEventView(creatorID: currentUserViewModel.user.id, isCommunityEvent: false)) {
                            Text("Create Event")
                                .font(.headline)
                                .foregroundColor(.purple)
                                .frame(width: 150, height:40)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 3).foregroundColor(.red)
                                )
                        }
                        Spacer()
                    }.padding()
                    
                }
                
                
                
                
                
                
                
                
                
                
                
            }.frame(width: UIScreen.main.bounds.width)
            .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    
                    ToolbarItem(placement: .principal) {
                        LogoOnTopMiddleView()
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CurrentUserProfile().environmentObject(currentUserViewModel)
                        } label: {
                            
                            if let profileImageURL = currentUserViewModel.user.profileImageURL {
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
            }.linearGradientBackground()

            
        //}
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //HomeView()
        EmptyView()
    }
}
