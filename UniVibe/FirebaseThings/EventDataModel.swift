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
    
    static func fetchByID(id: String, completion: @escaping (Event?) -> Void) async {
        let docRef = FirestoreManager.shared.db.collection("events").document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    let events = self.decodeObj(id: document.documentID, data: data)
                    completion(events)
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
            print("Error encoding Event: \(error)")
            return [:]
        }
    }

    private static func decodeObj(id: String, data: [String: Any]) -> Event {
        return Event(id: id, data: data)
    }
    
}
