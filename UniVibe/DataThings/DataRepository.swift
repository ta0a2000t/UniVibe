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
    
    func getUserByID(id: String) -> User? {
        return users.first { $0.id == id }
    }
    
    func getEventByID(id: String) -> Event? {
        return events.first { $0.id == id }
    }
    
    func getCommunityByID(id: String) -> Community? {
        return communities.first { $0.id == id }
    }
    
    func getUsersByIDs(ids: [String]) -> [User] {
        return users.filter { ids.contains($0.id) }
    }
    
    func getEventsByIDs(ids: [String]) -> [Event] {
        return events.filter { ids.contains($0.id) }
    }
    
    func getCommunitiesByIDs(ids: [String]) -> [Community] {
        return communities.filter { ids.contains($0.id) }
    }
    

    // Fetch data and populate properties
    func fetchData() {
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
