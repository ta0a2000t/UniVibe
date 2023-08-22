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
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    if let imageURL = community.profileImageURL {
                        Image(imageURL).resizable().frame(width: .infinity, height:200)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 10)
                                     
                            ).padding(.horizontal)
                        
                    } else {
                        // nothing?
                    }
                    
                    
                    
                    Text(community.fullname).font(.title).bold().padding(.vertical).padding(.horizontal)
                    
                    MembersDetailsView(membersCount: community.membersIDs.count).padding(.horizontal).padding(.bottom)
                    
                    TitleAndBodyView(title:"Description", textBody: community.description).padding(.horizontal).padding(.bottom)
                    
                    SectionAndSelectionsView(title: "Topics", selections: community.interests).padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text("Past Events").font(.title2).bold().padding(.leading)
                        HorizontalEventGridView(events: Event.MOCK)
                    }
                    
                    
                }
                
            }.linearGradientBackground()
            

            
            
            
            
        
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(systemName: "person.3.sequence.fill")
            }
        }
    }
}

struct CommunityProfileView_Previews: PreviewProvider {
    static var previews: some View {
        
        CommunityProfileView(community: Community.MOCK[0])
        
    }
}
