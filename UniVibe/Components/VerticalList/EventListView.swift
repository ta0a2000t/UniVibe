//
//  EventListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/21/23.
//

import SwiftUI

struct EventListView: View {
    let events : [Event]
    var body: some View {
        
        
        LazyVStack(spacing:3) {
            ForEach(events) { event in
                EventInListView(event: event)
            }
            
        }
        
        
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(events: Event.MOCK)
    }
}
