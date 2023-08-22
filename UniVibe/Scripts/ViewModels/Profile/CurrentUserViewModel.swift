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


class UserViewModel: ObservableObject {
    private var userListener: ListenerRegistration? // Store the listener instance

    @Published var currentUser: User
    
    
    init(currentUser: User) {
        
        self.currentUser = currentUser
        setupListeners()
    }
    
    private func setupListeners() {
        
        // Listen for changes to current user document
        userListener = UserDataModel.listenForChangesByID(userID: currentUser.id) { updatedUser in
            DispatchQueue.main.async {
                self.currentUser = updatedUser
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
        return DataRepository.getEventsByIDs(ids: self.currentUser.reservedEventsIDs)
    }
    
    func getCreatedEvents() -> [Event] {
        return DataRepository.getEventsByIDs(ids: self.currentUser.createdEventsIDs)
    }
    
    func getCommunities() -> [Community] {
        return DataRepository.getCommunitiesByIDs(ids: self.currentUser.communitiesIDs)
    }
    
    func getFriends() -> [User] {
        return DataRepository.getUsersByIDs(ids: self.currentUser.friendsIDs)
    }
    
    func getEventsCount() -> Int {
        let uniqueEventIDs = Set(currentUser.reservedEventsIDs + currentUser.createdEventsIDs)
        return uniqueEventIDs.count
    }
    
    func getFriendsCount() -> Int {
        return currentUser.friendsIDs.count
    }
    
    func getCommunitiesCount() -> Int {
        return currentUser.communitiesIDs.count
    }
    
}


class CurrentUserViewModel: UserViewModel {
    func addCreatedEvent(event: Event) {
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: currentUser.id, propertyName: "createdEventsIDs", item: event.id)
        }
        
        // update disk
        self.currentUser.createdEventsIDs.append(event.id)
    }
    
    func addReservedEvent(event: Event) {
        //event.attendees =
        
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: currentUser.id, propertyName: "reservedEventsIDs", item: event.id)
        }
        
        // update disk
        self.currentUser.reservedEventsIDs.append(event.id)
    }
    
    func addCommunity(community: Community) {
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: currentUser.id, propertyName: "communitiesIDs", item: community.id)
        }
        
        // update disk
        self.currentUser.communitiesIDs.append(community.id)
    }
    
    
    
    
    func addFriend(user: User) {
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: currentUser.id, propertyName: "friendsIDs", item: user.id)
        }
        
        // update disk
        self.currentUser.friendsIDs.append(user.id)
    }
}
