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
    @ObservedObject var feedViewModel = FeedViewModel()
    @EnvironmentObject var currentUserViewModel: CurrentUserViewModel

    var body: some View {
        VStack{
            Button {
                print(feedViewModel.getSortedEvents().count)
            } label : {
                Text("print events count")
            }
            
            
            
            StyledScrollableFullScreenView(scrollViewContent:feedItemsView, title: "Feed")
        }
    }
    
    var feedItemsView: some View {
        LazyVStack(spacing:3) {
            ForEach(feedViewModel.getSortedEvents()) { event in
                if let eventBinding = DataRepository.getEventBindingByID(for: event.id) {
                    EventInListView(event: eventBinding)
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
