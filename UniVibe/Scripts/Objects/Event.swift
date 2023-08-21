//
//  Event.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import Foundation
import SwiftUI

class Event: Identifiable, Codable {
    let id: String
    let creatorID: String // Reference to the creator (User or Community)
    let creationDate: Date
    let isCommunityEvent: Bool

    var title: String
    var description: String
    var imageURL: String?
    var date: Date
    var attendees: [String] // IDs of users attending the event
    var numberOfHours: Int // Number of hours for the event
    
    var latitude: Double // Latitude coordinate
    var longitude: Double // Longitude coordinate
    var locationName: String // Name of the event location
    var locationDescription: String // Description of the event location
    
    var maxAttendeesCount: Int

    init(id: String, creatorID: String, creationDate: Date, isCommunityEvent: Bool, title: String, description: String, imageURL: String?, date: Date, attendees: [String], numberOfHours: Int, latitude: Double, longitude: Double, locationName: String, locationDescription: String, maxAttendeesCount: Int) {
        self.id = id
        self.creatorID = creatorID
        self.creationDate = creationDate
        self.isCommunityEvent = isCommunityEvent
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.date = date
        self.attendees = attendees
        self.numberOfHours = numberOfHours
        
        self.latitude = latitude
        self.longitude = longitude
        self.locationName = locationName
        self.locationDescription = locationDescription
        self.maxAttendeesCount = maxAttendeesCount
    }
    
    init(id: String, data: [String: Any]) {
        self.id = id
        self.creatorID = data["creatorID"] as? String ?? ""
        self.creationDate = MyDateFormaters.decodeDate(from: data["creationDate"] as! String)!
        self.isCommunityEvent = data["isCommunityEvent"] as? Bool ?? false
        
        self.title = data["title"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.imageURL = data["imageURL"] as? String
        
             
        self.date = MyDateFormaters.decodeDate(from: data["date"] as! String)!
        
        
        self.attendees = data["attendees"] as? [String] ?? []
        self.numberOfHours = data["numberOfHours"] as? Int ?? 1
        
        self.latitude = data["latitude"] as? Double ?? 0.0
        self.longitude = data["longitude"] as? Double ?? 0.0
        self.locationName = data["locationName"] as? String ?? ""
        self.locationDescription = data["locationDescription"] as? String ?? ""
        
        self.maxAttendeesCount = data["maxAttendeesCount"] as? Int ?? 1
    }
    
    
    
    
    
    
    static var MOCK = [
        Event(id: UUID().uuidString, creatorID: UUID().uuidString, creationDate: Date(), isCommunityEvent: true, title: "LEVELS Night #6 - Terraforming Mars: Ares Expedition!", description: "Join us for fun!", imageURL: "billiard_img", date: Date(), attendees: [], numberOfHours: 3, latitude: 12.3456, longitude: -78.9012, locationName: "Stamp Student Union", locationDescription: "2nd floor next to ballroom 102.", maxAttendeesCount: 4),
        Event(id: UUID().uuidString, creatorID: UUID().uuidString, creationDate: Date(), isCommunityEvent: true, title: "Community Event", description: "Join us for fun!", imageURL: nil, date: Date(), attendees: [], numberOfHours: 2, latitude: 12.3456, longitude: -78.9012, locationName: "Campus Park", locationDescription: "First floor next to door.", maxAttendeesCount: 12)
    ]
    
    // could be used to transfer user to google maps app
    func getGoogleMapsURL() -> URL? {
        return URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")
    }
    func getAppleMapsURL() -> URL? {
        return URL(string: "maps://?saddr=&daddr=\(latitude),\(longitude)")
    }
    
    func copyableLocationLink() -> String {
        let googleMapsBaseURL = URL(string: "https://www.google.com/maps")!

        let destinationQuery = "q=\(latitude),\(longitude)"

        let fullURLString = "\(googleMapsBaseURL)?\(destinationQuery)"
        return fullURLString
    }
    func copyLocationToClipBoard() {
        UIPasteboard.general.string = self.copyableLocationLink()
    }
    func launchAppleMaps() {
        let url = self.getAppleMapsURL()
        if UIApplication.shared.canOpenURL(url!) {
              UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
}
