//
//  ListOfAttendeesView.swift
//  UniVibe
//
//  Created by Taha Al on 8/22/23.
//

import SwiftUI

struct ListOfAttendeesView: View {
    @Environment (\.dismiss) var dismiss

    let attendees: [User]
    
    init(attendees: [String]) {
        self.attendees = DataRepository.getUsersByIDs(ids: attendees)
    }
    
    var body: some View {
        StyledScrollableFullScreenView(scrollViewContent: scrollViewContent, title: "Attendees")
    }
    
    var scrollViewContent: some View {
        ScrollView {
            if attendees.isEmpty {
                VStack {
                    Image(systemName: "person.fill.questionmark")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text("No attendees yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                LazyVStack(spacing: 3) {
                    ForEach(attendees, id: \.id) { user in
                        UserInListView(user: user)
                    }
                }
                .padding(.top, 8)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct ListOfAttendeesView_Previews: PreviewProvider {
    static var previews: some View {
        //ListOfAttendeesView(attendees: User.MOCK_USERS)
        Text("")
    }
}

// use later to make the list synchronized with db
class ListOfAttendeesViewModel : ObservableObject{
    
}
