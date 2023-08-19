//
//  CommunityDataModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation
import FirebaseFirestore

class CommunityDataModel: ObservableObject {
    
    @MainActor
    static func fetchAll() async throws -> [Community] {
        let querySnapshot = try await FirestoreManager.shared.db.collection("communities").getDocuments()
        let communities = querySnapshot.documents.map { queryDocumentSnapshot -> Community in
            let data = queryDocumentSnapshot.data()
            return Community(id: queryDocumentSnapshot.documentID, data: data)
        }
        return communities
    }
    

    static func addToDB(community: Community) async -> Bool {
        var success = true
        let data = self.encodeObj(community: community)
        FirestoreManager.shared.db.collection("communities").document(community.id).setData(data) { error in
            if let error = error {
                print("Error adding Community: \(error)")
                success = false
            }
        }
        return success
    }
    
    static func fetchByID(id: String, completion: @escaping (Community?) -> Void) async {
        let docRef = FirestoreManager.shared.db.collection("communities").document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    let communities = self.decodeObj(id: document.documentID, data: data)
                    completion(communities)
                }


            } else {
                completion(nil) // Community document does not exist or error occurred
            }
        }
    }

    
    private static func encodeObj(community: Community) -> [String: Any] {
        do {
            var jsonObject = try JSONSerialization.jsonObject(with: JSONEncoder().encode(community)) as! [String: Any]
            jsonObject["id"] = nil // Exclude the id property
            return jsonObject
        } catch {
            print("Error encoding Community: \(error)")
            return [:]
        }
    }

    private static func decodeObj(id: String, data: [String: Any]) -> Community {
        return Community(id: id, data: data)
    }
    
}
