//
//  EventViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/17/23.
//
import Foundation
import FirebaseFirestore

class EventViewModel: ObservableObject {

    @Published var events = [Event]() // initializing empty array
    static let COLLECTION_NAME = "events"
    
    init() {
        fetchAll()
    }
    
    private func fetchAll() {
        
        FirestoreManager.shared.db.collection(EventViewModel.COLLECTION_NAME).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.events = documents.map { queryDocumentSnapshot -> Event in
                let data = queryDocumentSnapshot.data()
                return Event(id: queryDocumentSnapshot.documentID, data: data)
            }
        }
    }

    static func addToDB(event: Event) -> Bool {
        var success = true
        let data = self.encodeObj(event: event)
        FirestoreManager.shared.db.collection(EventViewModel.COLLECTION_NAME).document(event.id).setData(data) { error in
            if let error = error {
                print("Error adding event: \(error)")
                success = false
            }
        }
        return success
    }
    
    static func fetchByID(id: String, completion: @escaping (Event?) -> Void) {
        let docRef = FirestoreManager.shared.db.collection(EventViewModel.COLLECTION_NAME).document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    let event = self.decodeObj(id: document.documentID, data: data)
                    completion(event)
                }


            } else {
                completion(nil) // Event document does not exist or error occurred
            }
        }
    }

    
    private static func encodeObj(event: Event) -> [String: Any] {
        do {
            var jsonObject = try JSONSerialization.jsonObject(with: JSONEncoder().encode(event)) as! [String: Any]
            jsonObject["id"] = nil // Exclude the id property
            return jsonObject
        } catch {
            print("Error encoding event: \(error)")
            return [:]
        }
    }

    private static func decodeObj(id: String, data: [String: Any]) -> Event {
        return Event(id: id, data: data)
    }
    
}
