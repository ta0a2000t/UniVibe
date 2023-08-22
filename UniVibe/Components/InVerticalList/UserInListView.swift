//
//  UserInListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import SwiftUI

struct UserInListView: View {
    let user: User
    var body: some View {
        NavigationLink(destination: UserProfileView(user: user)) {
                HStack {
                    if let profileImageURL = user.profileImageURL {
                        Image(profileImageURL).resizable().scaledToFit().frame(width: 55, height: 55).clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(user.fullname).font(.headline).bold()
                        Text("\(user.getEventsCount()) events")
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right").padding()
                    
                }.padding(8)
                    .background(Color.green.opacity(0.5))
                    .cornerRadius(10)
            
            
        }

    }
    
}

struct UserInListView_Previews: PreviewProvider {
    static var previews: some View {
        UserInListView(user: User.MOCK_USERS[0])
    }
}
