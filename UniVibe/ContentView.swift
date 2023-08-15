//
//  ContentView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MainTabView(currentUser: User.MOCK_USERS[0])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
