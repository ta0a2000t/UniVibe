//
//  MyDateFormaters.swift
//  UniVibe
//
//  Created by Taha Al on 8/20/23.
//

import Foundation
final class MyDateFormaters {
    static let decodeFormatter = ISO8601DateFormatter()
    static let encodeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static func decodeDate(from dateString: String) -> Date? {
        return decodeFormatter.date(from: dateString)
    }
    
    static func encodeDate(_ date: Date) -> String {
        return encodeFormatter.string(from: date)
    }
}

/*

// Example usage
let dateString = "2022-01-31T02:22:40Z"
if let date = MyDateFormaters.decodeDate(from: dateString) {
    print(date.description)
}

let dateToEncode = Date()
let encodedString = MyDateFormaters.encodeDate(dateToEncode)
print(encodedString)

*/
