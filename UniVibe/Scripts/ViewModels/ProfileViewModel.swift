//
//  ProfileViewModel.swift
//  UniVibe
//
//  Created by Taha Al on 8/18/23.
//

import Foundation

// currentUserViewModel
class ProfileViewModel: ObservableObject {
    @Published var currentUser: User
    @Published var createdEvents: [Event] = []
    @Published var reservedEvents: [Event] = []
    @Published var communities: [Community] = []
    @Published var friends: [User] = []

    @MainActor
    init(currentUser: User) {
        self.currentUser = currentUser
        /*
        // Fetch created and reserved events in parallel
        Task {
            await withTaskGroup(of: Event?.self) { group in
                for eventID in currentUser.createdEventsIDs + currentUser.reservedEventsIDs {
                    group.addTask {
                        return await EventDataModel.fetchByID(id: eventID)
                    }
                }
                for await event in group {
                    if let event = event {
                        if currentUser.createdEventsIDs.contains(event.id) {
                            createdEvents.append(event)
                        } else if currentUser.reservedEventsIDs.contains(event.id) {
                            reservedEvents.append(event)
                        }
                    }
                }
            }
        }

        Task {
            await withTaskGroup(of: Community?.self) { group in
                for communityID in currentUser.communitiesIDs {
                    group.addTask {
                        return await CommunityDataModel.fetchByID(id: communityID)
                    }
                }
                
                let fetchedCommunities = await group.reduce(into: [Community]()) { result, community in
                    if let community = community {
                        result.append(community)
                    }
                }
                
                DispatchQueue.main.async {
                    self.communities = fetchedCommunities
                }
            }
        }
        

        Task {
            await withTaskGroup(of: User?.self) { group in
                for friendID in currentUser.friendsIDs {
                    group.addTask {
                        return await UserDataModel.fetchByID(id: friendID)
                    }
                }
                
                let fetchedFriends = await group.reduce(into: [User]()) { result, friend in
                    if let friend = friend {
                        result.append(friend)
                    }
                }
                
                DispatchQueue.main.async {
                    self.friends = fetchedFriends
                }
            }
        }
        
        
         */
        
        
    }
    
    
    @MainActor
    func addCreatedEvent(event: Event) {
        // upload to db
        Task{
            await UserDataModel.appendItemToList(userID: currentUser.id, propertyName: "createdEventsIDs", item: event.id)
            self.createdEvents.append(event)
        }
        
        // get here
        self.currentUser.createdEventsIDs.append(event.id)
    }
    
    func addReservedEvent(event: Event) {
        self.reservedEvents.append(event)
        self.currentUser.reservedEventsIDs.append(event.id)
    }
    
    
}

