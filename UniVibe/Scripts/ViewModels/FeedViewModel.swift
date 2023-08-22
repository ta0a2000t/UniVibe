//
//  FeedViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/21/23.
//

import Foundation
import Combine
import FirebaseFirestore

/// 1. the FeedViewModel makes a listener for events
/// 2. the listeners updates DataRepository.events
/// 3. whenever DataRepository.events  gets updated, FeedViewModel.events will be updated

// the updates to events come whenever (DataRepository.events) changes
class FeedViewModel: ObservableObject {
    @Published private var events: [Event]

    private var cancellables: Set<AnyCancellable> = []
    private var listener: ListenerRegistration? // Store the listener instance

    init() {
        // Initialize events based on DataRepository
        events = DataRepository.shared.events

        
        //  using the sink operator to listen for changes in DataRepository.shared.$events (which is a Publisher). When changes occur, the closure inside sink is executed
        DataRepository.shared.$events.receive(on: DispatchQueue.main).sink { [weak self] updatedEvents in
            self?.events = updatedEvents
        }.store(in: &cancellables)

        
        
        listenForChanges()
        
    }
    
    // from new to old
    func getSortedEvents() -> [Event] {
        return self.events.sorted { event1, event2 in
            return event1.creationDate > event2.creationDate
        }
    }

    
    
    deinit {
        // Remove the listener when the view model is deallocated
        removeListener()
    }
    
    private func listenForChanges() {
        listener = EventDataModel.listenForChanges { updatedEvents in
            DispatchQueue.main.async {
                DataRepository.shared.events = updatedEvents
            }
        }
    }

    private func removeListener() {
        listener?.remove() // Remove the Firestore listener
    }
    
    
}
