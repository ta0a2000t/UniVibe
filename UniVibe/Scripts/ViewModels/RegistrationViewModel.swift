//
//  RegistrationViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullname: String = ""
    @Published var bio: String = ""
    
    @Published var interests: [String] = []
    @Published var lookingTo: [String] = []
    
    @Published var createdEventsIDs: [String] = []
    @Published var reservedEventsIDs: [String] = []
    
    @Published var communitiesIDs: [String] = []
    @Published var friendsIDs: [String] = []

    
    
    func createUser() async throws {
        do {
            try await AuthService.shared.createUser(email: email, password: password, username: username)
        } catch {
            throw error
        }
    }
    
}
