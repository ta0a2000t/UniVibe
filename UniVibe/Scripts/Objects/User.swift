//
//  User.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import Foundation

class User: Identifiable, Codable {
    let id: String
    let email: String

    var username: String
    var profileImageURL: String?
    var fullname: String
    var bio: String?
    var createdEventsIDs: [String]
    var reservedEventsIDs: [String]
    var interests: [String]
    var lookingTo: [String]
    var communitiesIDs: [String]
    var friendsIDs: [String]
    
    init(id: String, username: String, profileImageURL: String?, fullname: String, bio: String?, email: String, createdEventsIDs: [String], reservedEventsIDs: [String], interests: [String], lookingTo: [String], communitiesIDs: [String], friendsIDs: [String]) {
        self.id = id
        self.username = username
        self.profileImageURL = profileImageURL
        self.fullname = fullname
        self.bio = bio
        self.email = email
        self.createdEventsIDs = createdEventsIDs // events created by the user.
        
        self.reservedEventsIDs = reservedEventsIDs // events not created by the user, but the user signed up for.
        
        self.interests = interests
        self.lookingTo = lookingTo
        
        self.communitiesIDs = communitiesIDs
        self.friendsIDs = friendsIDs
    }
    
    static var MOCK_USERS: [User] = [
        User(id: NSUUID().uuidString, username: "john_doe", profileImageURL: "zuckerberg", fullname: "John Doe", bio: "A music enthusiast", email: "john@example.com", createdEventsIDs: ["event1", "event2"], reservedEventsIDs: ["event3", "event4"], interests: ["outdoor", "swimming"], lookingTo: ["making friends"], communitiesIDs: [NSUUID().uuidString, NSUUID().uuidString, NSUUID().uuidString], friendsIDs: [NSUUID().uuidString, NSUUID().uuidString, NSUUID().uuidString]),
        User(id: NSUUID().uuidString, username: "jane_doe2", profileImageURL: "zuckerberg", fullname: "Jane Doe2", bio: "An art lover", email: "jane@example.com", createdEventsIDs: ["event5", "event6"], reservedEventsIDs: ["event7", "event8"], interests: ["art", "painting"], lookingTo: ["finding study partners"], communitiesIDs: [NSUUID().uuidString, NSUUID().uuidString], friendsIDs: [NSUUID().uuidString])
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
    static func initMock() -> [User] {
        //var result: [User] = []
        /*
        for _ in 1...3 {
            
            let id = NSUUID().uuidString
            let userJSON = """
                {
                        "id": "\(id)", "username": "zuck999", "profileImageURL": "zuckerberg", "fullname":"Mark Zuckerberg", "bio":"I am a hominoid lizard", "email":"zuckzuck@gmail.com"
                }
                """
            
            if let jsonData = userJSON.data(using: .utf8) {
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: jsonData)
                    
                    result.append(user)
                    
                } catch {
                    print("Error decoding user: \(error)")
                }
            }
            
        }
         */
        
        
        //return result
        return []
    }

    
    
    //initMock()
    // .init(id: NSUUID().uuidString, username: "zuck999", profileImageURL: "zuckerberg", fullname:"Mark Zuckerberg", bio:"I am a hominoid lizard", email:"zuckzuck@gmail.com")
    
}

