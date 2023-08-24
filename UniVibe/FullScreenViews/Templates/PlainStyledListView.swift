//
//  PlainStyledListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/23/23.
//

import SwiftUI

struct PlainStyledListView: View {
    let items : [SearchResultItemProtocol]
    
    var body: some View {
        List(items, id: \.id) { item in
            
            if let community = item as? Community {
                if let index = DataRepository.shared.communities.firstIndex(where: { $0.id == community.id }) {
                    let communityBindingIndex = index // Capture the index in a separate variable
                    
                    SearchResultItemProtocolInList(item: Binding.constant(DataRepository.shared.communities[communityBindingIndex]))
                        .listRowBackground(Color.green.opacity(0.1))
                }
            } else if let user = item as? User {
                if let index = DataRepository.shared.users.firstIndex(where: { $0.id == user.id }) {
                    let userBindingIndex = index // Capture the index in a separate variable
                    
                    SearchResultItemProtocolInList(item: Binding.constant(DataRepository.shared.users[userBindingIndex]))
                        .listRowBackground(Color.gray.opacity(0.1))
                }
            }
               
        }.listStyle(.plain)
           
            
    }
}



struct SearchResultItemProtocolInList: View {
    @Binding var item : SearchResultItemProtocol
    var body: some View {


        NavigationLink {
            
            if let community = item as? Community {
                CommunityProfileView(community: community)
                
            } else if let user = item as? User {
                    UserProfileView(user: user)
            }
             
        } label: {
            HStack {
                if let community = item as? Community {
                    Image(systemName: "person.3")
                        .resizable().scaledToFit().frame(width: 40)
                    
                } else if let user = item as? User {
                    // if user.profileImageURL: show pic
                    Image(systemName: "person")
                        .resizable().scaledToFit().frame(width: 40)
                    
                }
                

                

                VStack(alignment: .leading) {
                    Text(item.fullname).scaledToFit().bold().padding(.bottom, 1)
                    HStack {
                        Image(systemName: "figure.socialdance")
                        Text("\(item.getEventsCount())").bold()
                    }
                }.padding(.leading)
                //Spacer()
                //Image(systemName: "chevron.right")
            }
        }

    }
}

struct PlainStyledListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PlainStyledListView(items: User.MOCK_USERS)
        }
    }
}
