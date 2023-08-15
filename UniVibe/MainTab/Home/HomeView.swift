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
            ScrollView {
                HStack{
                    VStack(alignment:.leading) {
                        Text("Hi \(currentUser.fullname)!").font(.title2).bold().padding(.bottom)
                        
                        
                        
                        HStack {
                            Text("Reserved Events").font(.headline)
                            
                            
                        }
                    }
                    Spacer()
                }.padding(.leading).padding(.top)
                
                
                
                
                
                
                
                
                
                
                
            }.frame(width: UIScreen.main.bounds.width)
            .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("univibe_logo").resizable().scaledToFit().frame(height: 30)
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
