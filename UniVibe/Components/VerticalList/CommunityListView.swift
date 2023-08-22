//
//  CommunityListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct CommunityListView: View {
    let communities: [Community]
    var body: some View {
        
        
        LazyVStack(spacing:3) {
            ForEach(communities) { community in
                CommunityInListView(community: community)
            }
            
        }
            
        
    }
}

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityListView(communities: Community.MOCK)
        }
    }
}
