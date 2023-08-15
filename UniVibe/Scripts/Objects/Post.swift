//
//  Post.swift
//  UniVibe
//
//  Created by Taha Al on 8/14/23.
//

import Foundation

// works like a twitter post.
// for announcements (by a Community)
// for personal reflections (by a User)

class Post: Identifiable, Codable {
    let id: String
    let creatorID: String // Reference to the user/community who created the post
    let creationDate: Date

    var title: String
    var content: String
    var isCommunityPost: Bool
    
    init(id: String, creatorID: String, creationDate: Date, title: String, content: String, isCommunityPost: Bool) {
        self.id = id
        self.creatorID = creatorID
        self.creationDate = creationDate
        self.title = title
        self.content = content
        self.isCommunityPost = isCommunityPost
    }
    static var MOCK = [Post(id: "123", creatorID: "user123", creationDate: Date(), title: "My Post", content: "Hello, world!", isCommunityPost: false),
                       Post(id: "123", creatorID: "user123", creationDate: Date(), title: "My Post", content: "Hello, world!", isCommunityPost: false)
    ]
}

extension Post: Hashable{
    // conform to hashable
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    // conform to Equatable
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
