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
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem()], spacing: 10) {
                    ForEach(events) { event in
                        NavigationLink(destination: EventProfileView(event: event).navigationBarBackButtonHidden(true)) {
                            PastEventInGridView(event: event)
                            
                        }

                    }
                }.padding()
                Spacer()
            }.frame(height: 170)
            
            

            
        }

    }
}

struct HorizontalEventGridView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalEventGridView(events: Event.MOCK)
    }
}
