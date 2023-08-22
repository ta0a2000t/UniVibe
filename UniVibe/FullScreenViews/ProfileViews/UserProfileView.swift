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
            ScrollView {
                VStack(alignment: .leading){
                    
                    if let imageURL = user.profileImageURL {
                        Image(imageURL).resizable().frame(width: UIScreen.main.bounds.width, height:200)
                            .padding(.horizontal)
                    } else {
                        // nothing?
                    }
                    
                    
                }
                
            }.linearGradientBackground()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(systemName: "person.fill")
            }
        }
         
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: User.MOCK_USERS[0])
    }
}
