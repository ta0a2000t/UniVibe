//
//  HomeView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct HomeView: View {    
    @State var showCreateEventView: Bool = false
    
    @ObservedObject var currentUserViewModel = CurrentUserViewModel.shared
    var body: some View {
        //NavigationView{
            VStack {
                Button {
                    
                    print(DataRepository.getUserByID(id: CurrentUserViewModel.shared.user.id)!.toDictionary())
                } label : {
                    Text("Name: \(CurrentUserViewModel.shared.user.fullname)")
                    Text("print data")
                }
                
                VStack() {
                    VStack {

                        Text("Reserved Events").font(.title2).bold()
                        
                        EventListView(events: CurrentUserViewModel.shared.getReservedEvents()).frame(minHeight: 100, maxHeight: 400)
                        

                    }.padding(.bottom)
                    
                    
                    VStack {
                        Text("Created Events").font(.title2).bold()
                        HorizontalEventGridView(events: CurrentUserViewModel.shared.getCreatedEvents())
                        
                    }.padding(.bottom)
                    
                    
                    

                    Spacer()
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: ChooseEventTypeView(userID: CurrentUserViewModel.shared.user.id)) {
                            StylishCreateEventButton()
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
                            CurrentUserProfile()
                        } label: {
                            VStack {
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
                                Text(" \(currentUserViewModel.user.fullname)")
                            }

                        }

                        
                        
                }
            }.linearGradientBackground()

            
        //}
        
    }
}

struct StylishCreateEventButton: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "plus")
                .imageScale(.large)
                .foregroundColor(Color.primary)
            Text("Create Event")
                .font(.headline)
                .foregroundColor(Color.primary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.secondary.opacity(0.2))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.primary, lineWidth: 2)
        )
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //HomeView()
        EmptyView()
    }
}
