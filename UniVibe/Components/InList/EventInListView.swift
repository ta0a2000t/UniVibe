//
//  EventInListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct EventInListView: View {
    //let event: Event
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("WED, AUG 23 | 4:00 PM GMT+3").font(.subheadline).foregroundColor(.green).padding(.bottom, 1).padding(.top, 2)
                
                Text("LEVELS Night #6 - Terraforming Mars: Ares Expedition!").font(.callout).bold()
                    //.padding(.bottom, 1)
                
                
                Spacer()
                HStack {
                    Text("2 going").bold().padding(.trailing)
                    Spacer()
                    Text("LEVELS Game Nights").font(.footnote)

                }.padding(.bottom, 2)
                
            }
            
            Spacer()
            
            Image("zuckerberg").resizable().scaledToFit().frame(width: 70, height: 70).clipShape(RoundedRectangle(cornerRadius: 10)).padding(.trailing, 3)
            
        }.frame(height: 1)
        
    }
}

struct EventInListView_Previews: PreviewProvider {
    static var previews: some View {
        EventInListView()
    }
}
