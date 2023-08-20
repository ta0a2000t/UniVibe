//
//  AuthService.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
    }
    
    @MainActor
    func createUser(email: String, password: String, data: Dictionary<String, Any>) async throws {
        // create user account on firebase
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        
        self.userSession = result.user
        
        //upload data
        let user = User(id: result.user.uid, data: data)
        await uploadUserData(user: user)
    }

    func loadUserData() async throws {
        
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
    
    func uploadUserData(user: User) async {
        do {
            try await UserDataModel.addToDB(user: user)
        } catch{
            print("uploading new user data failed: \(error.localizedDescription)")
        }
    }
}
