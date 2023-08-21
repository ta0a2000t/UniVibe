//
//  DataRepository.swift
//  UniVibe
//
//  Created by Taha Al on 8/21/23.
//

import Foundation

// Global Data Repository

//  only gets data updates by the listeners that are set by viewModels (i.e FeedViewModel)
final class DataRepository: ObservableObject {
    static let shared = DataRepository()

    // need it to be published so that Combine can see it
    @Published var events = [Event]()
    @Published var users = [User]()
    @Published var communities = [Community]()

    init() {
        fetchData()
    }
    
    static func getUserByID(id: String) -> User? {
        return DataRepository.shared.users.first { $0.id == id }
    }
    
    static func getEventByID(id: String) -> Event? {
        return DataRepository.shared.events.first { $0.id == id }
    }
    
    static func getCommunityByID(id: String) -> Community? {
        return DataRepository.shared.communities.first { $0.id == id }
    }
    
    static func getUsersByIDs(ids: [String]) -> [User] {
        return DataRepository.shared.users.filter { ids.contains($0.id) }
    }
    
    static func getEventsByIDs(ids: [String]) -> [Event] {
        return DataRepository.shared.events.filter { ids.contains($0.id) }
    }
    
    static func getCommunitiesByIDs(ids: [String]) -> [Community] {
        return DataRepository.shared.communities.filter { ids.contains($0.id) }
    }
    

    // Fetch data and populate properties
    private func fetchData() {
        // Fetch current user's data
        Task {
            // Fetch events
            self.communities = try await CommunityDataModel.fetchAll()
        }
        
        Task {
            // Fetch events
            self.events = try await EventDataModel.fetchAll()
        }

        Task{
            // Fetch users
            self.users = try await UserDataModel.fetchAll()
        }
    }
}
