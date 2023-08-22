//
//  Community.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import Foundation
class Community: Identifiable, Codable , SearchResultItemProtocol{
    let id: String
    let email: String
    
    var fullname: String
    var description: String
    var profileImageURL: String?
    var membersIDs: [String] // IDs of users who are part of the community
    var organizerIDs: [String] // the IDs of users who can add events to this community
    var createdEventsIDs: [String] // the IDs of events created by this community
    
    var interests: [String]
    
    init(id: String, fullname: String, description: String, profileImageURL: String?, membersIDs: [String], email: String, organizerIDs: [String], createdEventsIDs: [String] = [], interests: [String]) {
        self.id = id
        self.fullname = fullname
        self.description = description
        self.profileImageURL = profileImageURL
        self.membersIDs = membersIDs
        self.email = email
        self.organizerIDs = organizerIDs
        self.createdEventsIDs = createdEventsIDs
        self.interests = interests
    }
    
    init(id: String, data: [String: Any]) {
        self.id = id
        self.email = data["email"] as? String ?? ""
        self.fullname = data["fullname"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String
        self.membersIDs = data["membersIDs"] as? [String] ?? []
        self.organizerIDs = data["organizerIDs"] as? [String] ?? []
        self.createdEventsIDs = data["createdEventsIDs"] as? [String] ?? []
        self.interests = data["interests"] as? [String] ?? []
    }

    
    
    
    // Community(id: "community123", fullname: "Music Lovers", description: "For those who love music.", profileImageURL: nil, membersIDs: ["user123", "user456"], email: "musiclovers@example.com")
    
}
extension Community: Hashable{
    // conform to hashable
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    // conform to Equatable
    static func == (lhs: Community, rhs: Community) -> Bool {
        return lhs.id == rhs.id
    }
}


extension Community {
    static func initMock() -> [Community] {
        var result: [Community] = []
        
        
        /*
        for _ in 1...3 {
            let id = UUID().uuidString
            let membersIDs = [UUID().uuidString, UUID().uuidString, UUID().uuidString]
            
            let userJSONDict: [String: Any] = [
                "id": id,
                "fullname": "LEVELS Game Nights",
                "description": "We are board games enjoyers.",
                "profileImageURL": "levelsimg",
                "membersIDs": membersIDs,
                "email": "levels123@gmail.com"
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: userJSONDict, options: [])
                let decoder = JSONDecoder()
                let community = try decoder.decode(Community.self, from: jsonData)
                result.append(community)
            } catch {
                print("Error decoding Community: \(error)")
            }
        }*/
        result.append(Community(id: UUID().uuidString, fullname: "Music Lovers", description: "For those who love music.", profileImageURL: "zuckerberg", membersIDs: [UUID().uuidString, UUID().uuidString], email: "musiclovers@example.com", organizerIDs: [], interests: ["Board Games", "Card Games", "Fun Games", "Games"]))
        result.append(Community(id: UUID().uuidString, fullname: "Music Lovers", description: "For those who love music.", profileImageURL: nil, membersIDs: [UUID().uuidString, UUID().uuidString], email: "musiclovers@example.com", organizerIDs: [], interests: ["Board Games", "Card Games", "Fun Games", "Games"]))
        result.append(Community(id: UUID().uuidString, fullname: "Music Lovers", description: "For those who love music.", profileImageURL: nil, membersIDs: [UUID().uuidString, UUID().uuidString], email: "musiclovers@example.com", organizerIDs: [], interests: ["Board Games", "Card Games", "Fun Games", "Games"]))

        return result
    }
    
    static var MOCK: [Community] = initMock()
    // .init(id: NSUUID().uuidString, username: "zuck999", profileImageURL: "zuckerberg", fullname:"Mark Zuckerberg", bio:"I am a hominoid lizard", email:"zuckzuck@gmail.com")
    
    

    
    func createEvent(title: String, description: String, date: Date, location: String) {
        /*
         // TODO make this work
         guard let currentUserID = AuthenticationManager.shared.currentUser?.id, organizerIDs.contains(currentUserID) else {
             print("You are not authorized to create events in this community.")
             return
         }
         
         */
        
        // Create an event and add its ID to the community's createdEvents
        //let event = Event(id: UUID().uuidString, creatorID: id, title: title, description: description, date: date, location: location, attendees: [], isCommunityEvent: true)
        
        // TODO
        // Save the event to your data model or send it to a server
        //
        
        
        //createdEventsIDs.append(event.id)
    }



    
}


