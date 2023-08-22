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

class AuthService : ObservableObject {
    @Published var userSession: FirebaseAuth.User? = nil
    @Published var currentUser: User? = nil
    
    static let shared = AuthService()
    
    init() {

    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        
        print("initializing")
        try await loadUserData()
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
        self.userSession = Auth.auth().currentUser
        guard let currentUid = self.userSession?.uid else { return }
        
        self.currentUser = await UserDataModel.fetchByID(id: currentUid)
        
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
