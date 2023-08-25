//
//  MyCategories.swift
//  UniVibe
//
//  Created by Taha Al on 8/25/23.
//

import Foundation

protocol MyCategories {
    func allCategoriesCombined() -> [String]
    func getCategoryArrayByName(name: String) -> [String]
    func getCategoryNames() -> [String]
}

struct InterestsCategories: Codable, MyCategories {
    var socialAndGameActivities: [String]
    var intellectualAndCreativeActivities: [String]
    var casualAndEntertainmentActivities: [String]
    var outdoorAndAdventureActivities: [String]
    var sportsAndPhysicalActivities: [String]
    var artsAndCrafts: [String]
    var healthAndWellness: [String]
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case socialAndGameActivities = "Social and Game Activities"
        case intellectualAndCreativeActivities = "Intellectual and Creative Activities"
        case casualAndEntertainmentActivities = "Casual and Entertainment Activities"
        case outdoorAndAdventureActivities = "Outdoor and Adventure Activities"
        case sportsAndPhysicalActivities = "Sports and Physical Activities"
        case artsAndCrafts = "Arts and Crafts"
        case healthAndWellness = "Health and Wellness"
    }
    
    init() {
        socialAndGameActivities = []
        intellectualAndCreativeActivities = []
        casualAndEntertainmentActivities = []
        outdoorAndAdventureActivities = []
        sportsAndPhysicalActivities = []
        artsAndCrafts = []
        healthAndWellness = []
    }
    
    // Conforming to MyCategories protocol
    func allCategoriesCombined() -> [String] {
        return socialAndGameActivities +
               intellectualAndCreativeActivities +
               casualAndEntertainmentActivities +
               outdoorAndAdventureActivities +
               sportsAndPhysicalActivities +
               artsAndCrafts +
               healthAndWellness
    }
    
    func getCategoryArrayByName(name: String) -> [String] {
        if let key = CodingKeys(rawValue: name) {
            return getArrayByCategory(category: key)
        }
        return []
    }
    
    func getArrayByCategory(category: CodingKeys) -> [String] {
        switch category {
        case .socialAndGameActivities:
            return socialAndGameActivities
        case .intellectualAndCreativeActivities:
            return intellectualAndCreativeActivities
        case .casualAndEntertainmentActivities:
            return casualAndEntertainmentActivities
        case .outdoorAndAdventureActivities:
            return outdoorAndAdventureActivities
        case .sportsAndPhysicalActivities:
            return sportsAndPhysicalActivities
        case .artsAndCrafts:
            return artsAndCrafts
        case .healthAndWellness:
            return healthAndWellness
        }
    }
    
    func getCategoryNames() -> [String] {
        return CodingKeys.allCases.map { $0.rawValue }
    }
}


struct GoalsCategories: Codable, MyCategories {
    var personalGrowth: [String]
    var socialConnections: [String]
    var recreationAndLeisure: [String]
    var romanticInterests: [String]
    var educationalAndAcademic: [String]
    var emotionalWellBeing: [String]
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case personalGrowth = "Personal Growth"
        case socialConnections = "Social Connections"
        case recreationAndLeisure = "Recreation and Leisure"
        case romanticInterests = "Romantic Interests"
        case educationalAndAcademic = "Educational and Academic"
        case emotionalWellBeing = "Emotional Well-being"
    }
    
    init() {
        personalGrowth = []
        socialConnections = []
        recreationAndLeisure = []
        romanticInterests = []
        educationalAndAcademic = []
        emotionalWellBeing = []
    }
    
    // Conforming to MyCategories protocol
    func allCategoriesCombined() -> [String] {
        return personalGrowth +
               socialConnections +
               recreationAndLeisure +
               romanticInterests +
               educationalAndAcademic +
               emotionalWellBeing
    }
    
    func getCategoryArrayByName(name: String) -> [String] {
        if let key = CodingKeys(rawValue: name) {
            return getArrayByCategory(category: key)
        }
        return []
    }
    
    func getArrayByCategory(category: CodingKeys) -> [String] {
        switch category {
        case .personalGrowth:
            return personalGrowth
        case .socialConnections:
            return socialConnections
        case .recreationAndLeisure:
            return recreationAndLeisure
        case .romanticInterests:
            return romanticInterests
        case .educationalAndAcademic:
            return educationalAndAcademic
        case .emotionalWellBeing:
            return emotionalWellBeing
        }
    }
    
    func getCategoryNames() -> [String] {
        return CodingKeys.allCases.map { $0.rawValue }
    }
}


