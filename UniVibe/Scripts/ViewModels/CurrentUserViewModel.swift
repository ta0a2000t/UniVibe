//
//  CurrentUserViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/18/23.
//

import Foundation
class CurrentUserViewModel: ObservableObject {
    @Published var currentUser: User
    @Published var createdEvents: [Event] = []
    @Published var reservedEvents: [Event] = []
    @Published var communities: [Community] = []
    @Published var friends: [User] = []

    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    

    // ... rest of the code
}
