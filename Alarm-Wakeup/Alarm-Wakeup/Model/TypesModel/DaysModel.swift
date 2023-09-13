//
//  DaysTypeModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/24/23.
//

import Foundation

enum Days: Int, Identifiable, CaseIterable, Codable {
    static let maxValue: Int = 7

    var id: Int { self.rawValue }

    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    var rawValueFromOne: Int {
        return self.rawValue+1
    }

    var firstLetter: String {
        switch self {
        case .sunday:
            return "S"
        case .monday:
            return "M"
        case .tuesday:
            return "T"
        case .wednesday:
            return "W"
        case .thursday:
            return "T"
        case .friday:
            return "F"
        case .saturday:
            return "S"
        }
    }

    var nextOfIt: Days {
        return Days(rawValue: (self.rawValue+1)%7)!
    }

    func getDiffinDay(from: Days) -> Int {
        var diff = from.rawValue - self.rawValue
        if diff < 0 {
            diff += Self.maxValue
        }
        return diff
    }

    static func fromDate(_ date: Date) -> Days? {
        return Days(rawValue: date.get(.weekday) - 1)
    }

    static var weekdays: Set<Days> {
        return [.monday, .tuesday, .wednesday, .thursday, .friday]
    }

    static func daysToIntegers(days: Set<Days>) -> [Int] {
        days.map { $0.rawValue }
    }

    static func integersToDays(_ daysInNumber: [Int]) -> Set<Days> {
        Set(daysInNumber.compactMap({ Days(rawValue: $0) }))
    }

}

// Describe days
extension Days {

    private static func isWeekdays(_ days: Set<Days>) -> Bool {
        if days.count == 5 {
            for day in days where day == Days.saturday || day == Days.sunday {
                return false
            }
            return true
        }
        return false
    }

    private static func isWeekends(_ days: Set<Days>) -> Bool {
        if days.count == 2 {
            for day in days where day != Days.saturday && day != Days.sunday {
                return false
            }
            return true
        }
        return false
    }

    private static func getDaysByLetter(_ days: Set<Days>) -> String {
        return days.reduce(into: "") { partialResult, day in
            partialResult = "\(partialResult) \(day.firstLetter)"
        }
    }

    static func daysDecription(days: Set<Days>) -> String {
        switch days.count {
        case maxValue:
            return "Every day"
        case days.count where isWeekdays(days):
            return "Weekdays"
        case days.count where isWeekends(days):
            return "Weekends"
        default:
            return getDaysByLetter(days)
        }
    }
}
