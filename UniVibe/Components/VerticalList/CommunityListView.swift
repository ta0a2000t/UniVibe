//
//  CommunityListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct CommunityListView: View {
    @Binding var communities: [Community]
    var body: some View {
        
        LazyVStack(spacing:3) {
            ForEach(communities) { community in
                
                if let communityBinding = DataRepository.getCommunityBindingByID(for: community.id) {
                    CommunityInListView(community: communityBinding)
                }

                
            }
            
        }
            
        
    }
}

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityListView(communities: .constant(Community.MOCK))
        }
    }
}
