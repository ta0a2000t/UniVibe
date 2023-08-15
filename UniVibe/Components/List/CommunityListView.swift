//
//  CommunityListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct CommunityListView: View {
    var body: some View {
        NavigationView {
            
            ScrollView {
                LazyVStack(spacing:12) {
                    ForEach(Community.MOCK) { community in
                        
                        NavigationLink(destination: CommunityProfileView(community: community)) {
                            CommunityInListView(membersCount: community.membersIDs.count, communityName: community.fullname)
                            
                        }
                    }
                    
                    
                }
            }
        }
    }
}

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListView()
    }
}
