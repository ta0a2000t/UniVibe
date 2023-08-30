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
    
    static func fetchByID(id: String) async -> Community? {
        let docRef = FirestoreManager.shared.db.collection("communities").document(id)
        
        do {
            let document = try await docRef.getDocument()
            
            if let data = document.data() {
                let community = decodeObj(id: document.documentID, data: data)
                return community
            }
        } catch {
            // Handle any errors that occurred while fetching the document
            print("Error fetching community document: \(error)")
        }
        
        return nil
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
    
    
    static func listenForChangesByID(communityID: String, completion: @escaping (Community) -> Void) -> ListenerRegistration {
        let communityListener = FirestoreManager.shared.db.collection("communities")
            .document(communityID)
            .addSnapshotListener { documentSnapshot, error in
                if let document = documentSnapshot, document.exists {
                    let data = document.data() ?? [:]
                    let updatedCommunity = decodeObj(id: document.documentID, data: data)
                    completion(updatedCommunity)
                }
            }
        
        return communityListener
    }
    
    
    // Listen for changes to the communities collection
    static func listenForChanges(completion: @escaping ([Community]) -> Void) -> ListenerRegistration {
        let listener = FirestoreManager.shared.db.collection("communities")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching communities: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                let updatedCommunities = documents.compactMap { document in
                    let data = document.data()
                    return decodeObj(id: document.documentID, data: data)
                }

                completion(updatedCommunities)
            }
        
        return listener
    }
    
    
    static func updateCommunityProperty(communityID: String, propertyName: String, newValue: Any) async {
        let communityRef = FirestoreManager.shared.db.collection("communities").document(communityID)
        
        do {
            let document = try await communityRef.getDocument()
            
            if var data = document.data() {
                data[propertyName] = newValue
                
                try await communityRef.setData(data)
            }
        } catch {
            // Handle error
            print("Error updating community property: \(error)")
        }
    }
    
    
    
}
