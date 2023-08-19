//
//  UserViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/18/23.
//

import Foundation
import FirebaseFirestore

class UserViewModel: ObservableObject {

    @Published var users = [User]() // initializing empty array

    
    init() {
        fetchAll() // Initial fetch using MOCK_USERS
    }
    
    private func fetchAll() {
        
        FirestoreManager.shared.db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.users = documents.map { queryDocumentSnapshot -> User in
                let data = queryDocumentSnapshot.data()
                return User(id: queryDocumentSnapshot.documentID, data: data)
            }
        }
    }

    static func addToDB(user: User) -> Bool{
        var success = true
        let data = self.encodeObj(user: user)
        FirestoreManager.shared.db.collection("users").document(user.id).setData(data) { error in
            if let error = error {
                print("Error adding user: \(error)")
                success = false
            }
        }
        return success
    }
    
    static func fetchByID(id: String, completion: @escaping (User?) -> Void) {
        let docRef = FirestoreManager.shared.db.collection("users").document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    let user = self.decodeObj(id: document.documentID, data: data)
                    completion(user)
                }


            } else {
                completion(nil) // User document does not exist or error occurred
            }
        }
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
    
}
