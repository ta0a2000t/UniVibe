//
//  StringExtensions.swift
//  UniVibe
//
//  Created by Taha Al on 8/20/23.
//

import Foundation

extension String {
    func isValidFullname() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z\\s]*$", options: [])
        let range = NSRange(location: 0, length: self.utf16.count)
        let matches = regex.matches(in: self, options: [], range: range)
        return matches.count == 1
    }
}
