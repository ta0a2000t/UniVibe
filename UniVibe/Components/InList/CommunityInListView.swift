//
//  CommunityInListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct CommunityInListView: View {
    let community: Community
    
    var body: some View {
        HStack {
            if let profileImageURL = community.profileImageURL {
                Image(profileImageURL).resizable().scaledToFit().frame(width: 55, height: 55).clipShape(RoundedRectangle(cornerRadius: 10))
                
            }

            VStack(alignment: .leading) {
                Text(community.fullname).font(.headline).bold()
                Text("\(community.membersIDs.count) members")
            }
            Spacer()
            
        }.padding(.horizontal, 7)
            .frame(width: UIScreen.main.bounds.width, height: 65)
            .background(Color(.gray).opacity(0.85))
            .cornerRadius(10)
    }
}

struct CommunityInListView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityInListView(community: Community.MOCK[0])
    }
}
