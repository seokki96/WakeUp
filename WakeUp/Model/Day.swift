//
//  Day.swift
//  WakeUp
//
//  Created by a on 10/15/25.
//

import Foundation

enum Weekday: Int, CaseIterable {
    case sun, mon, tue, wed, thu, fri, sat
}

extension Weekday {
    
    static var allCases: [Weekday] {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return Calendar.current.weekdaySymbols.enumerated().compactMap { index, _ in
            return Weekday(rawValue: index)
        }
    }
    
    var dayName: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        return formatter.veryShortWeekdaySymbols[self.rawValue]
    }
}

