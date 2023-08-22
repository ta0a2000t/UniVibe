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
        NavigationView {
            StyledScrollableFullScreenView(scrollViewContent: EventListView(events: feedViewModel.getSortedEvents()), title: "Feed")
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
