//
//  ProfileViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/18/23.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore



import Combine

class CurrentUserViewModel: ObservableObject {
    static let shared = CurrentUserViewModel()
    var userListener: ListenerRegistration? // Store the listener instance
    @Published var user: User

    private init() {
        // Initialize currentUser here, assuming it's guaranteed to be non-nil
        //user = User.MOCK_USERS[0]
        user = AuthService.shared.currentUser!
        setupListeners()
    }
    
    // Call this method when the view model is deallocated
    deinit {
        removeListeners()
    }
    
    
    func isAttending(event: Event) -> Bool {
        return user.reservedEventsIDs.contains(event.id)
    }
    
    
    
    func addCreatedEvent(event: Event) {
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: user.id, propertyName: "createdEventsIDs", item: event.id)
        }
        
        // update disk
        self.user.createdEventsIDs.append(event.id)
    }
    
    func addReservedEvent(event: Event) {
        //event.attendees =
        
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: user.id, propertyName: "reservedEventsIDs", item: event.id)
        }
        
        // update disk
        self.user.reservedEventsIDs.append(event.id)
    }
    
    func addOrganizingCommunity(community: Community) {
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: self.user.id, propertyName: "organizingCommunitiesIDs", item: community.id)
        }
        
        // update disk
        self.user.organizingCommunitiesIDs.append(community.id)
    }
    
    func addJoinedCommunity(community: Community) {
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: self.user.id, propertyName: "joinedCommunitiesIDs", item: community.id)
        }
        
        // update disk
        self.user.joinedCommunitiesIDs.append(community.id)
    }
    
    
    
    
    
    
    func addFriend(other: User) {
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: user.id, propertyName: "friendsIDs", item: other.id)
        }
        
        // update disk
        self.user.friendsIDs.append(other.id)
    }
    
    
    func removeReservedEvent(event: Event) {
        user.reservedEventsIDs.removeAll { $0 == event.id }
        
        if let diskUser = DataRepository.getUserByID(id: user.id) {
            diskUser.reservedEventsIDs.append(event.id)
        }

        // upload to db
        Task{
            await UserDataModel.updateUserProperty(userID: user.id ,propertyName: "reservedEventsIDs",newValue: user.reservedEventsIDs)
        }
        
    }
    
    func removeCreatedEvent(event: Event) {
        user.reservedEventsIDs.removeAll { $0 == event.id }
        
        if let diskUser = DataRepository.getUserByID(id: user.id) {
            diskUser.reservedEventsIDs.removeAll { $0 == event.id }
        }
        
        
        // upload to db
        Task{
            await UserDataModel.updateUserProperty(userID: user.id ,propertyName: "createdEventsIDs",newValue: user.createdEventsIDs)
        }
        
    }
    
    
    func removeJoinedCommunity(community: Community) {
        user.joinedCommunitiesIDs.removeAll { $0 == community.id }
        
        // upload to db
        Task{
            await UserDataModel.updateUserProperty(userID: user.id ,propertyName: "joinedCommunitiesIDs",newValue: user.joinedCommunitiesIDs)
        }
        
    }
    
    func removeFriend(friend: User) {
        user.friendsIDs.removeAll { $0 == friend.id }
                
        
        // upload to db
        Task{
            await UserDataModel.updateUserProperty(userID: user.id ,propertyName: "friendsIDs", newValue: user.friendsIDs)
        }
    }
    
    

    
    private func setupListeners() {
        
        // Listen for changes to current user document
        userListener = UserDataModel.listenForChangesByID(userID: user.id) { updatedUser in
            DispatchQueue.main.async {
                self.user = updatedUser
            }
        }
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
    
    func getJoinedCommunities() -> [Community] {
        return DataRepository.getCommunitiesByIDs(ids: self.user.joinedCommunitiesIDs)
    }
    
    func getOrganizingCommunities() -> [Community] {
        return DataRepository.getCommunitiesByIDs(ids: self.user.organizingCommunitiesIDs)
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
    
    func getJoinedCommunitiesCount() -> Int {
        return user.joinedCommunitiesIDs.count
    }
    
    
}
