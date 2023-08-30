//
//  User.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import Foundation

class User: Identifiable, Codable, SearchResultItemProtocol {
    let id: String
    let email: String
    
    var username: String
    var profileImageURL: String?
    var fullname: String
    var bio: String?
    var createdEventsIDs: [String]
    var reservedEventsIDs: [String]
    var interests: [String]
    var goals: [String]
    var joinedCommunitiesIDs: [String]
    var friendsIDs: [String]
    
    var organizingCommunitiesIDs: [String]
    
    init(id: String, username: String, profileImageURL: String?, fullname: String, bio: String?, email: String, createdEventsIDs: [String], reservedEventsIDs: [String], interests: [String], goals: [String], joinedCommunitiesIDs: [String], friendsIDs: [String], organizingCommunitiesIDs: [String]) {
        self.id = id
        self.username = username
        self.profileImageURL = profileImageURL
        self.fullname = fullname
        self.bio = bio
        self.email = email
        self.createdEventsIDs = createdEventsIDs // events created by the user.
        
        self.reservedEventsIDs = reservedEventsIDs // events not created by the user, but the user signed up for.
        
        self.interests = interests
        self.goals = goals
        
        self.joinedCommunitiesIDs = joinedCommunitiesIDs
        self.organizingCommunitiesIDs = organizingCommunitiesIDs
        
        self.friendsIDs = friendsIDs
        
    
    }
    
    
    init(id: String, data: Dictionary<String, Any>) {
        self.id = id
        self.email = data["email"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String
        self.fullname = data["fullname"] as? String ?? ""
        self.bio = data["bio"] as? String
        self.createdEventsIDs = data["createdEventsIDs"] as? [String] ?? []
        self.reservedEventsIDs = data["reservedEventsIDs"] as? [String] ?? []
        self.interests = data["interests"] as? [String] ?? []
        self.goals = data["goals"] as? [String] ?? []
        self.joinedCommunitiesIDs = data["joinedCommunitiesIDs"] as? [String] ?? []
        self.organizingCommunitiesIDs = data["organizingCommunitiesIDs"] as? [String] ?? []
        self.friendsIDs = data["friendsIDs"] as? [String] ?? []
        
        //super.init() // Call the superclass designated initializer if needed
    }
    
    

    
    func getEventsCount() -> Int{
        return createdEventsIDs.count + reservedEventsIDs.count
    }
    
    
    func addCreatedEvent(event: Event) {
        print("created \(event)")
        
        self.createdEventsIDs.append(event.id)
    }
    
    func getCreatedEvents() -> [Event] {
        return Event.MOCK
    }
    
    func getReservedEvents() -> [Event] {
        return Event.MOCK
    }
    
    func getPastEvents() -> [Event] {
        return Event.MOCK
    }
    
    func getCommunities() -> [Community] {
        return Community.MOCK
    }
    
    func getOrganizingCommunities() -> [Community] {
        return Community.MOCK
    }
    
    
    
    /*
     func addCreatedEvent(event: Event) {
         do {
             let db = Firestore.firestore()
             var eventCopy = event // Create a mutable copy of the event object
             eventCopy.creatorID = self.id // Set the creator ID to the user's ID
             
             // Convert the event to a dictionary
             if let eventDict = try eventCopy.toDictionary() {
                 // Store the event data in Firestore using the event's ID as the document ID
                 db.collection("events").document(event.id).setData(eventDict) { error in
                     if let error = error {
                         print("Error adding event: \(error)")
                     } else {
                         // Successfully added event to Firestore
                         print("Event added to Firestore: \(event.id)")
                         
                         // Add the event's ID to the user's createdEventsIDs
                         self.createdEventsIDs.append(event.id)
                     }
                 }
             }
         } catch {
             print("Error converting event to dictionary: \(error)")
         }
     }
     */
     
    
    static var MOCK_USERS: [User] = [
        User(id: NSUUID().uuidString, username: "john_doe", profileImageURL: "zuckerberg", fullname: "John Doe", bio: "A music enthusiast", email: "john@example.com", createdEventsIDs: ["event1", "event2"], reservedEventsIDs: ["event3", "event4"], interests: ["outdoor", "swimming"], goals: ["making friends"], joinedCommunitiesIDs: [], friendsIDs: [NSUUID().uuidString, NSUUID().uuidString, NSUUID().uuidString], organizingCommunitiesIDs: []),
        User(id: NSUUID().uuidString, username: "jane_doe2", profileImageURL: "zuckerberg", fullname: "Jane Doe2", bio: "An art lover", email: "jane@example.com", createdEventsIDs: ["event5", "event6"], reservedEventsIDs: ["event7", "event8"], interests: ["art", "painting"], goals: ["finding study partners"], joinedCommunitiesIDs: [], friendsIDs: [NSUUID().uuidString], organizingCommunitiesIDs: [])
    ]
}


extension User: Hashable{
    // conform to hashable
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    // conform to Equatable
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

}



extension User {
    func toDictionary() -> [String: Any] {
        var userDict: [String: Any] = [
            "id": id,
            "email": email,
            "username": username
        ]
        
        if let profileImageURL = profileImageURL {
            userDict["profileImageURL"] = profileImageURL
        } else {
            userDict["profileImageURL"] = ""
        }
        
        
        userDict["fullname"] = fullname
        
    
        if let bio = bio {
            userDict["bio"] = bio
        } else {
            userDict["bio"] = ""
        }
        
        userDict["createdEventsIDs"] = createdEventsIDs
        userDict["reservedEventsIDs"] = reservedEventsIDs
        userDict["interests"] = interests
        userDict["goals"] = goals
        userDict["joinedCommunitiesIDs"] = joinedCommunitiesIDs
        userDict["organizingCommunitiesIDs"] = organizingCommunitiesIDs
        userDict["friendsIDs"] = friendsIDs
        
        return userDict
    }
}



