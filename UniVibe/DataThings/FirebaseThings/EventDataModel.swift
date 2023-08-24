//
//  EventDataModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation
import FirebaseFirestore

class EventDataModel: ObservableObject {
    
    @MainActor
    static func fetchAll() async throws -> [Event] {
        let querySnapshot = try await FirestoreManager.shared.db.collection("events").getDocuments()
        let events = querySnapshot.documents.map { queryDocumentSnapshot -> Event in
            let data = queryDocumentSnapshot.data()
            return Event(id: queryDocumentSnapshot.documentID, data: data)
        }
        return events
    }
    

    static func addToDB(event: Event) async -> Bool {
        var success = true
        let data = self.encodeObj(event: event)
        FirestoreManager.shared.db.collection("events").document(event.id).setData(data) { error in
            if let error = error {
                print("Error adding Event: \(error)")
                success = false
            }
        }
        return success
    }
    
    
    static func fetchByID(id: String) async -> Event? {
        let docRef = FirestoreManager.shared.db.collection("events").document(id)
        
        do {
            let document = try await docRef.getDocument()
            
            if let data = document.data() {
                let event = decodeObj(id: document.documentID, data: data)
                return event
            }
        } catch {
            // Handle any errors that occurred while fetching the document
            print("Error fetching event document: \(error)")
        }
        
        return nil
    }
    
    


    
    private static func encodeObj(event: Event) -> [String: Any] {
        do {
            var jsonObject = try JSONSerialization.jsonObject(with: JSONEncoder().encode(event)) as! [String: Any]
            jsonObject["id"] = nil // Exclude the id property
            
            jsonObject["creationDate"] = MyDateFormaters.encodeDate(event.creationDate)
            jsonObject["date"] = MyDateFormaters.encodeDate(event.date)
            
            return jsonObject
        } catch {
            print("Error encoding Event: \(error)")
            return [:]
        }
    }

    private static func decodeObj(id: String, data: [String: Any]) -> Event {
        var mutableData = data
        mutableData["creationDate"] = MyDateFormaters.decodeDate(from: data["creationDate"] as! String)
        mutableData["date"] = MyDateFormaters.decodeDate(from: data["date"] as! String )
        
        
        return Event(id: id, data: data)
    }
    
    static func updateEventProperty(eventID: String, propertyName: String, newValue: Any) async {
        let eventRef = FirestoreManager.shared.db.collection("events").document(eventID)
        
        do {
            let document = try await eventRef.getDocument()
            
            if var data = document.data() {
                data[propertyName] = newValue
                
                try await eventRef.setData(data)
            }
        } catch {
            // Handle error
            print("Error updating event property: \(error)")
        }
    }
    
    static func listenForChangesByID(eventID: String, completion: @escaping (Event) -> Void) -> ListenerRegistration {
        let eventListener = FirestoreManager.shared.db.collection("events")
            .document(eventID)
            .addSnapshotListener { documentSnapshot, error in
                if let document = documentSnapshot, document.exists {
                    let data = document.data() ?? [:]
                    let updatedEvent = decodeObj(id: document.documentID, data: data)
                    completion(updatedEvent)
                }
            }
        
        return eventListener
    }
    
    // Listen for changes to the events collection
    static func listenForChanges(completion: @escaping ([Event]) -> Void) -> ListenerRegistration {
        let listener = FirestoreManager.shared.db.collection("events")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching events: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                let updatedEvents = documents.compactMap { document in
                    let data = document.data()
                    //print(data)
                    return decodeObj(id: document.documentID, data: data)
                }

                completion(updatedEvents)
            }
        
        return listener
    }

    
}
