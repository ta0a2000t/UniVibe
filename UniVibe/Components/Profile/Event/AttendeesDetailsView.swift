//
//  AttendeesDetailsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import SwiftUI

struct AttendeesDetailsView: View {
    let attendeesCount: Int
    var body: some View {
        
        VStack {

            
            HStack {
                Image(systemName: "person.fill.checkmark").resizable().scaledToFit().frame(width: 25)
                Text("\(attendeesCount)").font(.callout).bold()
                Spacer()
                //Text("View").padding(.leading).bold()
                Image(systemName: "chevron.right")
            }
            
            
            
        }.padding(10).padding(.trailing, 8).overlay(RoundedRectangle(cornerRadius: 20).foregroundColor(.red).opacity(0.2))
        
    }
}

struct AttendeesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeesDetailsView(attendeesCount: Event.MOCK[0].attendees.count)
    }
}
