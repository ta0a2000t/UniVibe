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

    private var db = Firestore.firestore()
    
    init() {
        fetchAllUsers() // Initial fetch using MOCK_USERS
    }
    
    private func fetchAllUsers() {
        
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
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

    func addUser(user: User) {
        let data = self.encodeUser(user: user)
        db.collection("users").document(user.id).setData(data) { error in
            if let error = error {
                print("Error adding user: \(error)")
            }
        }
    }

    private func decodeUser(id: String, data: [String: Any]) -> User {
        return User(id: id, data: data)
    }


    private func encodeUser(user: User) -> [String: Any] {
        do {
            var jsonObject = try JSONSerialization.jsonObject(with: JSONEncoder().encode(user)) as! [String: Any]
            jsonObject["id"] = nil // Exclude the id property
            return jsonObject
        } catch {
            print("Error encoding user: \(error)")
            return [:]
        }
    }

    
    func fetchUserByID(id: String, completion: @escaping (User?) -> Void) {
        let docRef = db.collection("users").document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let userData = document.data() {
                    let user = self.decodeUser(id: document.documentID, data: userData)
                    completion(user)
                }


            } else {
                completion(nil) // User document does not exist or error occurred
            }
        }
    }

    
    
}
