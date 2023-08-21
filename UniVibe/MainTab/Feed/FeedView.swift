//
//  FeedView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct FeedView: View {
    // don't want to be StateObject because that it keep FeedViewModel listeners On
    @ObservedObject var feedViewModel = FeedViewModel()
    @EnvironmentObject var currentUserViewModel: CurrentUserViewModel

    var body: some View {
        List(feedViewModel.events) { event in
            // Display event details
            Text("\(event.title)")
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
