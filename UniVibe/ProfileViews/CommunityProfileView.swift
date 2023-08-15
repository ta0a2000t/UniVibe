//
//  CommunityProfileView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct CommunityProfileView: View {
    let community : Community
    @Environment (\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            
            
            
            Text("id: \(community.id)")
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(community.fullname)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left").resizable()
                }
                
            }
            
        }
    }
}

struct CommunityProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityProfileView(community: Community.MOCK[0])
    }
}
