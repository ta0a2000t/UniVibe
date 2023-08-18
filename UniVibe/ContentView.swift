//
//  ContentView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: UserViewModel

    var body: some View {
        MainTabView(currentUser: User.MOCK_USERS[0]).environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
