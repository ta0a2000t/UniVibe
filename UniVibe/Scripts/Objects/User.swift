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
    
    init(id: String, username: String, profileImageURL: String?, fullname: String, bio: String?, email: String, createdEventsIDs: [String], reservedEventsIDs: [String]) {
        self.id = id
        self.username = username
        self.profileImageURL = profileImageURL
        self.fullname = fullname
        self.bio = bio
        self.email = email
        self.createdEventsIDs = createdEventsIDs
        self.reservedEventsIDs = reservedEventsIDs
    }
    
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
    static var MOCK_USERS: [User] = [User(id: NSUUID().uuidString, username: "john_doe", profileImageURL: "zuckerberg", fullname: "John Doe", bio: "A music enthusiast", email: "john@example.com", createdEventsIDs: ["event1", "event2"], reservedEventsIDs: ["event3", "event4"])
                                     ,
                                     User(id: NSUUID().uuidString, username: "john_doe", profileImageURL: "zuckerberg", fullname: "John Doe", bio: "A music enthusiast", email: "john@example.com", createdEventsIDs: ["event1", "event2"], reservedEventsIDs: ["event3", "event4"])
                                     ,User(id: NSUUID().uuidString, username: "john_doe", profileImageURL: "zuckerberg", fullname: "John Doe", bio: "A music enthusiast", email: "john@example.com", createdEventsIDs: ["event1", "event2"], reservedEventsIDs: ["event3", "event4"])
    ]
    
    
    //initMock()
    // .init(id: NSUUID().uuidString, username: "zuck999", profileImageURL: "zuckerberg", fullname:"Mark Zuckerberg", bio:"I am a hominoid lizard", email:"zuckzuck@gmail.com")
    
}

