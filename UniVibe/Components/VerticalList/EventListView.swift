//
//  EventListView.swift
//  UniVibe
//
//  Created by Taha Al on 8/21/23.
//

import SwiftUI

struct EventListView: View {
    let events : [Event]
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        List(events, id: \.id) { event in
            if let eventBinding = DataRepository.getEventBindingByID(for: event.id) {
                EventInListView(event: eventBinding)
                    .listRowBackground(Color.gray.opacity(0.1))
            } else {

                    EventInListView(event: .constant(event))
                    .listRowBackground(ColorUtilities.dynamicBackgroundColor(for: colorScheme).opacity(0.5))
                    
            }
        }.frame(minHeight: 100, maxHeight: 400).listStyle(.plain)
        
        
        
        
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(events: Event.MOCK)
    }
}
