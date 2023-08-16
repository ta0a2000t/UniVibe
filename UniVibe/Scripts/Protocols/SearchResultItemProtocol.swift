//
//  SearchableItemProtocol.swift
//  UniVibe
//
//  Created by Taha Al on 8/16/23.
//

import Foundation
protocol SearchResultItemProtocol {
    var id: String { get }
    var fullname: String { get }
    var profileImageURL: String? { get }
    // Add other common properties if needed
}
