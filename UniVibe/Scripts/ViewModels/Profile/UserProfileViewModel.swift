//
//  UserProfileViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/22/23.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    var userListener: ListenerRegistration? // Store the listener instance

    @Published var user: User
    
    
    init(user: User) {
        
        self.user = user
        setupListeners()
    }
    
    private func setupListeners() {
        
        // Listen for changes to current user document
        userListener = UserDataModel.listenForChangesByID(userID: user.id) { updatedUser in
            DispatchQueue.main.async {
                self.user = updatedUser
            }
        }
    }
    
    // Call this method when the view model is deallocated
    deinit {
        removeListeners()
    }
    
    private func removeListeners() {
        // Remove the Firestore listener for the current user
        userListener?.remove()
    }
    
    
    func getReservedEvents() -> [Event] {
        return DataRepository.getEventsByIDs(ids: self.user.reservedEventsIDs)
    }
    
    func getCreatedEvents() -> [Event] {
        return DataRepository.getEventsByIDs(ids: self.user.createdEventsIDs)
    }
    
    func getCommunities() -> [Community] {
        return DataRepository.getCommunitiesByIDs(ids: self.user.communitiesIDs)
    }
    
    func getFriends() -> [User] {
        return DataRepository.getUsersByIDs(ids: self.user.friendsIDs)
    }
    
    func getEventsCount() -> Int {
        let uniqueEventIDs = Set(user.reservedEventsIDs + user.createdEventsIDs)
        return uniqueEventIDs.count
    }
    
    func getFriendsCount() -> Int {
        return user.friendsIDs.count
    }
    
    func getCommunitiesCount() -> Int {
        return user.communitiesIDs.count
    }
}
