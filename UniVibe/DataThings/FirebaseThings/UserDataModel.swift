//
//  UserDataModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation
import FirebaseFirestore

class UserDataModel: ObservableObject {
    
    @MainActor
    static func fetchAll() async throws -> [User] {
        let querySnapshot = try await FirestoreManager.shared.db.collection("users").getDocuments()
        let users = querySnapshot.documents.map { queryDocumentSnapshot -> User in
            let data = queryDocumentSnapshot.data()
            return User(id: queryDocumentSnapshot.documentID, data: data)
        }
        return users
    }
    

    static func addToDB(user: User) async throws {
        
        let data = self.encodeObj(user: user)
        
        try await FirestoreManager.shared.db.collection("users").document(user.id).setData(data)
        
    }
    
    static func fetchByID(id: String) async -> User? {
        let docRef = FirestoreManager.shared.db.collection("users").document(id)
        
        do {
            let document = try await docRef.getDocument()
            
            if let data = document.data() {
                let user = decodeObj(id: document.documentID, data: data)
                return user
            }
        } catch {
            // Handle any errors that occurred while fetching the document
            print("Error fetching user document: \(error)")
        }
        
        return nil
    }

    
    private static func encodeObj(user: User) -> [String: Any] {
        do {
            var jsonObject = try JSONSerialization.jsonObject(with: JSONEncoder().encode(user)) as! [String: Any]
            jsonObject["id"] = nil // Exclude the id property
            return jsonObject
        } catch {
            print("Error encoding user: \(error)")
            return [:]
        }
    }

    private static func decodeObj(id: String, data: [String: Any]) -> User {
        return User(id: id, data: data)
    }
    
    static func appendItemToList(userID: String, propertyName: String, item: String) async {
        let userRef = FirestoreManager.shared.db.collection("users").document(userID)
        
        do {
            let document = try await userRef.getDocument()
            
            if var data = document.data(),
               var list = data[propertyName] as? [String] {
                list.append(item)
                data[propertyName] = list
                
                try await userRef.setData(data)
            }
        } catch {
            // Handle error
            print("Error appending item to list: \(error)")
        }
    }
    
    // try await UserDataModel.updateUserProperty(userID: "userID", propertyName: "createdEventsIDs", newValue: ["eventID1", "eventID2"])
    static func updateUserProperty(userID: String, propertyName: String, newValue: Any) async {
        let userRef = FirestoreManager.shared.db.collection("users").document(userID)
        
        do {
            let document = try await userRef.getDocument()
            
            if var data = document.data() {
                data[propertyName] = newValue
                
                try await userRef.setData(data)
            }
        } catch {
            // Handle error
            print("Error updating user property: \(error)")
        }
    }
    
    
    
}
