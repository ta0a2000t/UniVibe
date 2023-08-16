//
//  time_helpers.swift
//  UniVibe
//
//  Created by Taha Al on 8/15/23.
//

import Foundation

extension DateFormatter {
    static var eventDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d | h:mm a"
        return formatter
    }()
}

final class TimeHelpers {
    static func formatEventDate(_ date: Date) -> String {
        let formattedDate = DateFormatter.eventDateFormatter.string(from: date)
        let timeZone = TimeZone.current
        let timeZoneAbbreviation = timeZone.abbreviation() ?? ""
        return "\(formattedDate) \(timeZoneAbbreviation)"
    }
    
    static func timeAgoSinceDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()

        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: now)

        if let year = components.year, year >= 1 {
            return "\(year) year\(year > 1 ? "s" : "") ago"
        }

        if let month = components.month, month >= 1 {
            return "\(month) month\(month > 1 ? "s" : "") ago"
        }

        if let day = components.day, day >= 1 {
            return "\(day) day\(day > 1 ? "s" : "") ago"
        }

        if let hour = components.hour, hour >= 1 {
            return "\(hour) hour\(hour > 1 ? "s" : "") ago"
        }

        if let minute = components.minute, minute >= 1 {
            return "\(minute) minute\(minute > 1 ? "s" : "") ago"
        }

        return "Just now"
    }
    
    static func formatMonthDayYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func formatTimeWithDynamicTimeZone(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let timeString = dateFormatter.string(from: date)
        
        let timeZone = TimeZone.autoupdatingCurrent
        let timeZoneAbbreviation = timeZone.abbreviation(for: date)
        
        return "\(timeString) \(timeZoneAbbreviation ?? "")"
    }
    
    static func formatRangedDate(date: Date, numberOfHours: Int) -> String {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = numberOfHours

        let endDate = calendar.date(byAdding: dateComponents, to: date) ?? date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current

        let startDateString = dateFormatter.string(from: date)
        let endDateString = dateFormatter.string(from: endDate)

        return "\(startDateString) - \(endDateString) \(TimeZone.current.abbreviation() ?? "")"
    }

    
}



