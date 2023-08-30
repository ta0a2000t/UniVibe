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
    @Published var goals: [String] = []
    
    @Published var createdEventsIDs: [String] = []
    @Published var reservedEventsIDs: [String] = []
    
    @Published var joinedCommunitiesIDs: [String] = []
    @Published var friendsIDs: [String] = []

    
    
    
    func createUser() async throws {
        let data: [String: Any] = [
            "username": username,
            "email": email,
            "fullname": fullname,
            "bio": bio,
            "interests": interests,
            "goals": goals,
            "createdEventsIDs": createdEventsIDs,
            "reservedEventsIDs": reservedEventsIDs,
            "joinedCommunitiesIDs": joinedCommunitiesIDs,
            "friendsIDs": friendsIDs
        ]
        
        try await AuthService.shared.createUser(email: email, password: password, data: data)
        
        
        await resetFields()
    }
    
    
    
    @MainActor
    func resetFields() {
        username = ""
        email = ""
        password = ""
        fullname = ""
        bio = ""
        interests = []
        goals = []
        createdEventsIDs = []
        reservedEventsIDs = []
        joinedCommunitiesIDs = []
        friendsIDs = []
    }
    
}
