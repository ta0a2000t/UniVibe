//
//  EventProfileViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/22/23.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore


class EventViewModel: ObservableObject {
    var listener: ListenerRegistration? // Store the listener instance

    @Published var event: Event
    
    
    init(event: Event) {
        
        self.event = event
        setupListeners()
    }
    
    private func setupListeners() {
        
        // Listen for changes to current user document
        listener = EventDataModel.listenForChangesByID(eventID: event.id) { updatedEvent in
            DispatchQueue.main.async {
                self.event = updatedEvent
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
    
    func getAttendees() -> [User] {
        return DataRepository.getUsersByIDs(ids: self.event.attendees)
    }
    
    
    func getCreatingUser() ->  User? {
        return DataRepository.getUserByID(id: self.event.creatorID)
    }
    
    func getCreatingCommunity() -> Community? {
        return DataRepository.getCommunityByID(id: self.event.creatorID)
    }
    
    
    func addAttendee(user: User) {
        if self.event.attendees.contains(user.id) {
            print("addAttendee failed: user \(user.id) exists!")
            return
        }
        
        //locally
        self.event.attendees.append(user.id)
        /*
        if let event = DataRepository.getEventByID(id: self.event.id) {
            event.attendees.append(user.id)
        } */
        
        // db
        Task{
            await EventDataModel.updateEventProperty(eventID: event.id ,propertyName: "attendees", newValue: self.event.attendees)
        }

    }
    
    func removeAttendee(user: User) {
        // locally
        self.event.attendees.removeAll { $0 == user.id }
        /*
        if let event = DataRepository.getEventByID(id: self.event.id) {
            event.attendees.removeAll { $0 == user.id }
        }
         */
        
        // upload to db
        Task{
            await EventDataModel.updateEventProperty(eventID: event.id ,propertyName: "attendees", newValue: self.event.attendees)
        }
    }
    
    func isUserAttending(id: String) -> Bool {
        return self.event.attendees.contains(id)
    }
    
    
    
    
    
    
}
