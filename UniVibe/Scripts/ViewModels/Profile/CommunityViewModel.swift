//
//  CommunityProfileViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/22/23.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

class CommunityViewModel: ObservableObject {
    var listener: ListenerRegistration? // Store the listener instance

    @Published var community: Community
    
    
    init(community: Community) {
        self.community = community
        setupListeners()
    }
    
    private func setupListeners() {
        // Listen for changes to current user document
        listener = CommunityDataModel.listenForChangesByID(communityID: community.id) { updatedCommunity in
            DispatchQueue.main.async {
                self.community = updatedCommunity
            }
        }
    }
    
    // Call this method when the view model is deallocated
    deinit {
        removeListeners()
    }
    
    private func removeListeners() {
        // Remove the Firestore listener for the current user
        listener?.remove()
    }
    
    func getMembers() -> [User] {
        return DataRepository.getUsersByIDs(ids: self.community.membersIDs)
    }
    
    
    func getOrganizers() ->  [User] {
        return DataRepository.getUsersByIDs(ids: self.community.organizerIDs)
    }
    
    
    func addMember(user: User) {
        if self.community.membersIDs.contains(user.id) {
            print("addMember failed: user \(user.id) exists!")
            return
        }
        
        //locally
        self.community.membersIDs.append(user.id)
        /*
        if let community = DataRepository.getCommunityByID(id: self.community.id) {
            community.membersIDs.append(user.id)
        } */
        
        // db
        Task{
            await CommunityDataModel.updateCommunityProperty(communityID: community.id ,propertyName: "membersIDs", newValue: self.community.membersIDs)
        }

    }
    
    func removeMember(user: User) {
        // locally
        self.community.membersIDs.removeAll { $0 == user.id }
        /*
        if let community = DataRepository.getCommunityByID(id: self.community.id) {
            community.membersIDs.removeAll { $0 == user.id }
        }
         */
        
        // upload to db
        Task{
            await CommunityDataModel.updateCommunityProperty(communityID: community.id ,propertyName: "membersIDs", newValue: self.community.membersIDs)
        }
    }
    
    func addCreatedEvent(event: Event) {
        // update disk
        self.community.createdEventsIDs.append(event.id)
        
        // upload to db
        Task{
            await CommunityDataModel.updateCommunityProperty(communityID: community.id, propertyName:  "createdEventsIDs", newValue: self.community.createdEventsIDs)
        }
        

    }
}
