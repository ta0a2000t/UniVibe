//
//  FeedView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI
// TODO: fix style of ExploreView & copy the stuff here, so they have same style.

struct FeedView: View {
    // don't want to be StateObject because that it keep FeedViewModel listeners On
    @StateObject var feedViewModel = FeedViewModel()
    @ObservedObject var currentUserViewModel = CurrentUserViewModel.shared
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        VStack{
            
            
            List {
                ForEach(feedViewModel.getSortedEvents()) { event in
                    EventInListView(event: .constant(event))
                        .listRowBackground(ColorUtilities.dynamicBackgroundColor(for: colorScheme).opacity(0.5))
                }
            }.listStyle(.plain).navigationTitle("Feed")
                
            
            /*
            
            StyledScrollableFullScreenView(scrollViewContent:feedItemsView, title: "Feed")
             
             */
        }.linearGradientBackground()
    }
    
    var feedItemsView: some View {
        
        LazyVStack(spacing:24) {
            ForEach(feedViewModel.getSortedEvents()) { event in
                if let eventBinding = DataRepository.getEventBindingByID(for: event.id) {
                    EventInListView(event: eventBinding).padding(.horizontal)
                    //EventCardView(event: event)
                }
                
                
            }
            
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
