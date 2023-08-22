//
//  PastEventInGridView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct PastEventInGridView: View {
    var pastEventInGridViewModel : PastEventInGridViewModel
    let event : Event
    init(event: Event) {
        pastEventInGridViewModel = PastEventInGridViewModel(event: event)
        self.event = event
    }
    
    var body: some View {
        NavigationLink(destination: EventProfileView(event: event).navigationBarBackButtonHidden(true)) {
            
            VStack(alignment: .leading) {
                
                Text("\(TimeHelpers.timeAgoSinceDate(pastEventInGridViewModel.event.creationDate))").modifier(MyTimeStringModifier()).padding(.bottom, 1).bold()
                
                Text(pastEventInGridViewModel.event.title).lineLimit(nil).font(.callout).bold()
                
                Spacer()
                
                HStack {
                    HStack {
                        Image(systemName: "person.fill.checkmark").resizable().scaledToFit().frame(width: 18)
                        Text("\(pastEventInGridViewModel.event.attendees.count)").font(.footnote).bold()
                    }.padding(.trailing)
                    
                    Spacer()
                    Text(pastEventInGridViewModel.creatorName).font(.caption)

                }
                
            }.padding(.horizontal, 7).padding(.top, 5)
                .padding(.bottom, 5)
                .frame(width: 200, height: 150)
                .background(Color(.gray).opacity(0.85))
                .cornerRadius(10)
            
        }
        
        


    }
}

struct PastEventInGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PastEventInGridView(event: Event.MOCK[0])
        }
    }
}

class PastEventInGridViewModel {
    var user: User? = nil
    var community: Community? = nil
    var creatorName: String = "UNKNOWN"
    var event: Event
    
    init(event: Event) {
        var user : User? = nil
        var community : Community? = nil
        if event.isCommunityEvent {
            community = DataRepository.getCommunityByID(id: event.creatorID)
            if let retrivedComm = user {
                self.creatorName = retrivedComm.fullname
            }
        } else {
            user = DataRepository.getUserByID(id: event.creatorID)
            if let retrivedUser = user {
                self.creatorName = retrivedUser.fullname
            }
        }
        
        self.user = user
        self.community = community
        self.event = event
    }
}
