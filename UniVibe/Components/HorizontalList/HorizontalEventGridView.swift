//
//  HorizontalEventGridView.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import SwiftUI

struct HorizontalEventGridView: View {
    let events : [Event]
    var body: some View {
        
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem()], spacing: 8) {
                    ForEach(events) { event in
                        PastEventInGridView(event: event)
                    }
                }.frame(height: 160).padding(.leading, 8)
            }

        

    }
}

struct HorizontalEventGridView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalEventGridView(events: Event.MOCK)
    }
}
