//
//  UserProfileView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    @Environment (\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    if let imageURL = user.profileImageURL {
                        Image(imageURL).resizable().frame(width: UIScreen.main.bounds.width, height:200)
                            /*
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 10)
                                     
                                .fill(.purple))
                             */
                            .padding(.horizontal)
                    } else {
                        // nothing?
                    }
                    
                    
                }
                
            }.linearGradientBackground()
            

            
            
            
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(systemName: "person.fill")
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left").resizable()
                }
                
            }
            
        }.toolbarBackground(.visible)
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: User.MOCK_USERS[0])
    }
}
