//
//  EventInListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI



struct EventInListView: View {
    @Binding var event: Event
    
    var body: some View {
        NavigationLink(destination: EventProfileView(event: event)) {
            
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(TimeHelpers.formatEventDate(event.date)).modifier(MyTimeStringModifier()).padding(.bottom, 1).padding(.top, 2).bold()
                    
                    Text(event.title).font(.callout).bold()
                    
                     
                    Spacer()
                    HStack {
                        Text("\(event.attendees.count) going").padding(.trailing)
                        Spacer()
                        Text(DataRepository.getEventCreatorName(event: event)).font(.footnote)
                    }
                    
                }
                
                Spacer()
                
                if let imageUrl = event.imageURL {
                    Image(imageUrl).resizable().frame(width: 60, height: 60).clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    BlankEventPFPView().frame(width: 60, height: 60).clipShape(RoundedRectangle(cornerRadius: 10))
                }

                
            }.frame(height: 70)//.padding()//.background(.red.opacity(0.1))//.clipShape(RoundedRectangle(cornerRadius: 10))
                //.edgesIgnoringSafeArea(.horizontal)
            
        }

        
    }
}

struct EventInListView_Previews: PreviewProvider {
    static var previews: some View {
        EventInListView(event: .constant(Event.MOCK[0]))
    }
}
