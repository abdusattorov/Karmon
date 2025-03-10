//
//  DateFormatter.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 18/12/24.
//

import Foundation

extension Date {
    
    /// Converts a `Date` to a string with the given format.
    /// - Parameter format: The desired date format.
    /// - Returns: A string representation of the date.
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // day/month
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }

    /// "SATURDAY, 8 MARCH 2025"
    func toSectionHeaderFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX") // day/month
        formatter.timeZone = TimeZone.current
        return Calendar.current.isDateInToday(self) ? "TODAY" : formatter.string(from: self).uppercased()
    }

    /// Parses a string into a `Date` with the given format.
    static func fromString(_ dateString: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // day/month
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: dateString)
    }
}
