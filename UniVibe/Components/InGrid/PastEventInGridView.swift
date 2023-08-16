//
//  PastEventInGridView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct PastEventInGridView: View {
    let event: Event
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(TimeHelpers.timeAgoSinceDate(event.creationDate))").modifier(MyTimeStringModifier()).padding(.bottom, 1).bold()
            
            Text(event.title).lineLimit(nil).font(.callout).bold()
            
            Spacer()
            
            HStack {
                HStack {
                    Image(systemName: "person.fill.checkmark").resizable().scaledToFit().frame(width: 18)
                    Text("\(event.attendees.count)").font(.footnote).bold()
                }.padding(.trailing)
                
                Spacer()
                Text("LEVELS Game Nights").font(.caption)

            }
            
        }.padding(.horizontal, 7).padding(.top, 5)
            .padding(.bottom, 5)
            .frame(width: 200, height: 150)
            .background(Color(.gray).opacity(0.85))
            .cornerRadius(10)

    }
}

struct PastEventInGridView_Previews: PreviewProvider {
    static var previews: some View {
        PastEventInGridView(event: Event.MOCK[0])
    }
}
