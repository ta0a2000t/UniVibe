//
//  Event.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import Foundation

class Event: Identifiable, Codable {
    let id: String
    let creatorID: String // Reference to the creator (User or Community)
    let creationDate: Date
    let isCommunityEvent: Bool

    var title: String
    var description: String
    var imageURL: String?
    var date: Date
    var location: String
    var attendees: [String] // IDs of users attending the event
    
    init(id: String, creatorID: String, creationDate: Date, isCommunityEvent: Bool, title: String, description: String, imageURL: String?, date: Date, location: String, attendees: [String]) {
        self.id = id
        self.creatorID = creatorID
        self.creationDate = creationDate
        self.isCommunityEvent = isCommunityEvent
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.date = date
        self.location = location
        self.attendees = attendees
    }
    static var MOCK = [Event(id: "123", creatorID: "user123", creationDate: Date(), isCommunityEvent: true, title: "Community Event", description: "Join us for fun!", imageURL: nil, date: Date(), location: "Campus Park", attendees: [])
                       ,
        Event(id: "123", creatorID: "user123", creationDate: Date(), isCommunityEvent: true, title: "Community Event", description: "Join us for fun!", imageURL: nil, date: Date(), location: "Campus Park", attendees: [])
                       ]

}
