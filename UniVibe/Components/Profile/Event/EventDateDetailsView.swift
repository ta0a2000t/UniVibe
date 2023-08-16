//
//  EventDateDetailsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.


import SwiftUI

struct EventDateDetailsView: View {
    let date: Date
    let numberOfHours: Int
    
    var body: some View {
        HStack {
            Image(systemName: "calendar.badge.clock").resizable().scaledToFit().frame(width: 25)
            
            VStack(alignment: .leading) {
                Text(TimeHelpers.formatMonthDayYear(date:date)).font(.callout)
                Text(TimeHelpers.formatRangedDate(date:date, numberOfHours: numberOfHours)).font(.footnote)
                
            }.padding(.leading)
            
        }.padding(10).padding(.trailing, 8).overlay(RoundedRectangle(cornerRadius: 20).foregroundColor(.green).opacity(0.2))
        
    }
}

struct EventDateDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDateDetailsView(date: Date.now, numberOfHours: 4)
    }
}
