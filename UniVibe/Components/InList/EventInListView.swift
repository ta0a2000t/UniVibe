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
        HStack {
            VStack(alignment: .leading) {
                
                Text(TimeHelpers.formatEventDate(event.date)).modifier(MyTimeStringModifier()).padding(.bottom, 1).padding(.top, 2)
                
                Text(event.title).font(.callout).bold()
                    //.padding(.bottom, 1)
                
                
                Spacer()
                HStack {
                    Text("\(event.attendees.count) going").bold().padding(.trailing)
                    Spacer()
                    Text("LEVELS Game Nights").font(.footnote)

                }.padding(.bottom, 2)
                
            }
            
            Spacer()
            
            Image("zuckerberg").resizable().scaledToFit().frame(width: 70, height: 70).clipShape(RoundedRectangle(cornerRadius: 10)).padding(.trailing, 3)
            
        }.frame(height: 80)//.background(.red)
        
    }
}

struct EventInListView_Previews: PreviewProvider {
    static var previews: some View {
        EventInListView(event: Event.MOCK[0])
    }
}
