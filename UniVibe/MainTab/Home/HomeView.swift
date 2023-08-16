//
//  HomeView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct HomeView: View {
    let currentUser: User
    @State var showEditProfile: Bool = false
    var body: some View {
        NavigationStack{
            VStack {
                VStack(alignment:.trailing) {
                    Text(" \(currentUser.fullname)").font(.title3).bold().padding(.bottom)
                    
                    
                    
                    VStack {

                        Text("Reserved Events").font(.title2).bold()
                        ScrollView(.vertical) {
                            
                            
                            LazyVStack(spacing:12) {
                                
                                ForEach(Event.MOCK) { event in
                                    
                                    NavigationLink(destination: EventProfileView(event: event).navigationBarBackButtonHidden(true)) {
                                        EventInListView(event: Event.MOCK[0])
                                        
                                    }
                                }
                                
                            }
                        }.frame(height: 180)//.background(.gray)
                        
                        Divider()
                    }.padding(.bottom)
                    
                    
                    VStack {

                        Text("Past Events").font(.title2).bold()
                        HorizontalEventGridView(events: Event.MOCK)//.background(.gray)
                        
                        Divider()
                    }.padding(.bottom)
                    

                    Spacer()
                    
                }.padding(.horizontal)
                
                
                
                
                
                
                
                
                
                
                
            }.frame(width: UIScreen.main.bounds.width)
            .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("univibe_logo").resizable().scaledToFit().frame(height: 35)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CurrentUserProfile(currentUser: currentUser).navigationBarBackButtonHidden(true)
                        } label: {
                            
                            if let profileImageURL = currentUser.profileImageURL {
                                Image(profileImageURL)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .background(.gray)
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
        HomeView(currentUser: User.MOCK_USERS[0])
    }
}
