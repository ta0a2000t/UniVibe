//
//  CommunityListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct CommunityListView: View {
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing:12) {
                    ForEach(Community.MOCK) { community in
                        
                        NavigationLink(destination: CommunityProfileView(community: community).navigationBarBackButtonHidden(true)) {
                            CommunityInListView(community: community)
                            
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
