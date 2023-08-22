//
//  EventInListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI



struct EventInListView: View {
    let event: Event
    var body: some View {
        NavigationLink(destination: EventProfileView(event: event).navigationBarBackButtonHidden(true)) {
            
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(TimeHelpers.formatEventDate(event.date)).modifier(MyTimeStringModifier()).padding(.bottom, 1).padding(.top, 2).bold()
                    
                    Text(event.title).font(.callout).bold()
                        //.padding(.bottom, 1)
                    
                    
                    Spacer()
                    HStack {
                        Text("\(event.attendees.count) going").bold().padding(.trailing)
                        Spacer()
                        Text("LEVELS Game Nights").font(.footnote)

                    }.padding(.bottom, 2)
                    
                }.padding(.horizontal, 4)
                
                Spacer()
                
                if let imageUrl = event.imageURL {
                    Image(imageUrl).resizable().frame(width: 70, height: 70).clipShape(RoundedRectangle(cornerRadius: 10)).padding(.trailing, 3)
                } else {
                    Image(systemName:"figure.play").resizable().frame(width: 70, height: 70).background(.purple.opacity(0.2)).clipShape(RoundedRectangle(cornerRadius: 10)).padding(.trailing, 3)
                }

                
            }.frame(height: 80).background(.brown.opacity(0.3)).clipShape(RoundedRectangle(cornerRadius: 10))
            
            
        }

        
    }
}

struct EventInListView_Previews: PreviewProvider {
    static var previews: some View {
        EventInListView(event: Event.MOCK[0])
    }
}
