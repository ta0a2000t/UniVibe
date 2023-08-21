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
                MainTabView(currentUser: currentUser)
            }
        }
        
        /*.onAppear {
            // Apply dark mode color scheme to the entire view hierarchy
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    window.rootViewController?.overrideUserInterfaceStyle = .dark
                }
            }
        }
         */
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
