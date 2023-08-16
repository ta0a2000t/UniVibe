//
//  EventChatDetailsView.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import SwiftUI

struct EventChatDetailsView: View {
    var body: some View {
        HStack {
            Image(systemName: "ellipsis.message").resizable().scaledToFit().frame(width: 25)
            
            VStack(alignment: .leading) {
                Text("Event Chat").font(.callout)
                Text("Get updates & stay connected ").font(.footnote)
            }.padding(.leading)
            Spacer()
            Image(systemName: "chevron.right")
            
        }.padding(10).padding(.trailing, 8).overlay(RoundedRectangle(cornerRadius: 20).foregroundColor(.orange).opacity(0.2))
        
    }
}

struct EventChatDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventChatDetailsView()
    }
}
