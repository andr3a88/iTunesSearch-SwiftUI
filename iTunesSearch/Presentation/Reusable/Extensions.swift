//
//  Extensions.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 08/09/23.
//

import Foundation


extension String {

    private static var dateFormatterISO8601: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return dateFormatter
    }

    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }

    func formatDate() -> String {
        guard let date = Self.dateFormatterISO8601.date(from: self) else {
            return ""
        }
        return Self.dateFormatter.string(from: date)
    }
}
