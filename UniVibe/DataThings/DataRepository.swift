//
//  DataRepository.swift
//  UniVibe
//
//  Created by Taha Al on 8/21/23.
//

import Foundation

// Global Data Repository
import SwiftUI
//  only gets data updates by the listeners that are set by viewModels (i.e FeedViewModel)
final class DataRepository: ObservableObject {
    static let shared = DataRepository()

    // need it to be published so that Combine can see it
    @Published var events = [Event]()
    @Published var users = [User]()
    @Published var communities = [Community]()

    private var interestsCategories: InterestsCategories?
    private var goalsCategories: GoalsCategories?
    
    init() {
        fetchData()
        initInterestsCategories()
        initGoalsCategories()
    }
    
    /* Usage:
     if let userBinding = DataRepository.getUserBindingByID(for: user.id) {
         UserInListView(user: userBinding)
     }*/
    // READ ONLY
    static func getUserBindingByID(for userID: String) -> Binding<User>? {
        guard let index = DataRepository.shared.users.firstIndex(where: { $0.id == userID }) else {
            return nil
        }

        return Binding<User>(
            get: { DataRepository.shared.users[index] },
            set: {DataRepository.shared.users[index] = $0  }  //set: { DataRepository.shared.users[index] = $0 }
        )
    }
    // READ ONLY
    static func getEventBindingByID(for eventID: String) -> Binding<Event>? {
        guard let index = DataRepository.shared.events.firstIndex(where: { $0.id == eventID }) else {
            return nil
        }

        return Binding<Event>(
            get: { DataRepository.shared.events[index] },
            set: {_ in }  //set: { DataRepository.shared.events[index] = $0 }
        )
    }
    // READ ONLY
    static func getCommunityBindingByID(for communityID: String) -> Binding<Community>? {
        guard let index = DataRepository.shared.communities.firstIndex(where: { $0.id == communityID }) else {
            return nil
        }

        return Binding<Community>(
            get: { DataRepository.shared.communities[index] },
            set: {_ in }  //set: { DataRepository.shared.communities[index] = $0 }
        )
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
    
    static func getEventCreatorName(event: Event) -> String {
        if event.isCommunityEvent {
            return getCommunityByID(id: event.creatorID)?.fullname ?? "Unknown"
        } else {
            return getUserByID(id: event.creatorID)?.fullname ?? "Unknown"
        }
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
    
    
    
    private func initInterestsCategories() {
        if let path = Bundle.main.path(forResource: "InterestsCategories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let categories = try decoder.decode(InterestsCategories.self, from: data)
                
                // Use the categories object here
                self.interestsCategories = categories
            } catch {
                print("Failed reading json file Error: \(error)")
            }
        }
    }
    
    private func initGoalsCategories() {
        if let path = Bundle.main.path(forResource: "GoalsCategories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let categories = try decoder.decode(GoalsCategories.self, from: data)
                
                // Use the categories object here
                self.goalsCategories = categories
            } catch {
                print("Failed reading json file Error: \(error)")
            }
        }
    }
    
    func getInterestsCategories() -> InterestsCategories {
        if let interestsCats = self.interestsCategories {
            return interestsCats
        } else {
            return InterestsCategories()
        }
    }
    
    func getGoalsCategories() -> GoalsCategories {
        if let goalsCats = self.goalsCategories {
            return goalsCats
        } else {
            return GoalsCategories()
        }
    }
    
    
}
