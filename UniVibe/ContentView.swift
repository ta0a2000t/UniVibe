//
//  ContentView.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    @EnvironmentObject var dataRepository: DataRepository

    var body: some View {
        Group {
            if contentViewModel.userSession == nil {
                LoginView().environmentObject(registrationViewModel)
            } else if let currentUser = contentViewModel.currentUser {
                MainTabView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
