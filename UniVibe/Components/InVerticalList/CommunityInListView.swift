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
        NavigationLink(destination: CommunityProfileView(community: community)) {
            
            VStack{
                HStack {
                    if let profileImageURL = community.profileImageURL {
                        Image(profileImageURL).resizable().scaledToFit().frame(width: 55, height: 55).clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(community.fullname).font(.headline).bold()
                        Text("\(community.membersIDs.count) members")
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right").padding()
                    
                }.padding(8)
                    .background(Color.purple.opacity(0.5))
                    .cornerRadius(10)
            }
            
        }

    }
}

struct CommunityInListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityInListView(community: Community.MOCK[0])
        }
    }
}
