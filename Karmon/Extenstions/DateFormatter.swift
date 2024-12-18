//
//  DateFormatter.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 18/12/24.
//

import Foundation

extension Date {
    /// Creates a `Date` object from a string using the specified format.
    /// - Parameters:
    ///   - dateString: The string representing the date.
    ///   - format: The format of the date string (e.g., "yyyy-MM-dd", "MM/dd/yyyy").
    /// - Returns: A `Date` object if parsing is successful, otherwise `nil`.
    static func fromString(_ dateString: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: dateString)
    }
}
