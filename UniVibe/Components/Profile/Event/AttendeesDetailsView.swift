//
//  AttendeesDetailsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import SwiftUI

struct AttendeesDetailsView: View {
    @ObservedObject var attendeesDetailsViewModel : AttendeesDetailsViewModel
    
    init(event: Event) {
        attendeesDetailsViewModel = AttendeesDetailsViewModel(event: event)
    }
    
    
    var body: some View {
        NavigationLink(destination: ListOfAttendeesView(attendees: attendeesDetailsViewModel.event.attendees)) {
            VStack {

                
                HStack {
                    Image(systemName: "person.fill.checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    Text("\(attendeesDetailsViewModel.event.attendees.count) / \(attendeesDetailsViewModel.event.maxAttendeesCount)")
                        .font(.callout)
                        .bold()
                        .foregroundColor(attendeesDetailsViewModel.event.attendees.count < attendeesDetailsViewModel.event.maxAttendeesCount ? .green : .red)
                        .padding(.leading)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                
                
                
            }.padding(10).padding(.trailing, 8).overlay(RoundedRectangle(cornerRadius: 20).foregroundColor(.red).opacity(0.2))
        }
        
        
    }
}

struct AttendeesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeesDetailsView(event: Event.MOCK[0])
    }
}

class AttendeesDetailsViewModel: ObservableObject {
    @Published var event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    
}

