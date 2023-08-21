//
//  ExploreViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/19/23.
//

import Foundation
import Combine
import FirebaseFirestore

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var communities = [Community]()
    
    private var cancellables: Set<AnyCancellable> = []
    private var userListener: ListenerRegistration?
    private var communityListener: ListenerRegistration?

    init() {
        // Initialize users and communities based on DataRepository
        users = DataRepository.shared.users
        communities = DataRepository.shared.communities
        
        
        DataRepository.shared.$users.sink { [weak self] updatedUsers in
            self?.users = updatedUsers
        }.store(in: &cancellables)

        DataRepository.shared.$communities.sink { [weak self] updatedCommunities in
            self?.communities = updatedCommunities
        }.store(in: &cancellables)

        
        
        // Listen for changes in users and update DataRepository.users
        userListener = UserDataModel.listenForChanges { updatedUsers in
            DispatchQueue.main.async {
                DataRepository.shared.users = updatedUsers
            }
        }
        
        // Listen for changes in communities and update DataRepository.communities
        communityListener = CommunityDataModel.listenForChanges { updatedCommunities in
            DispatchQueue.main.async {
                DataRepository.shared.communities = updatedCommunities
            }
        }
    }
    
    deinit {
        // Remove listeners when the view model is deallocated
        userListener?.remove()
        communityListener?.remove()
    }
}



/*
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
*/
