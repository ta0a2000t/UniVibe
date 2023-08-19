//
//  ExploreViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var communities = [Community]()
    
    init() {
        Task {
            do {
                try await fetchUsers()
            } catch {
                // Handle error
                print("Error fetching users: \(error)")
            }
        }
        
        Task {
            do {
                try await fetchCommunities()
            } catch {
                // Handle error
                print("Error fetching users: \(error)")
            }
        }
        
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserDataModel.fetchAll()
    }
    
    
    @MainActor
    private func fetchCommunities() async throws {
        self.communities = try await CommunityDataModel.fetchAll()
    }
    
    
    
}
