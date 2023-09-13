//
//  Date+Extensions.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/21/23.
//

import Foundation

extension Date {

    func get(components: [Calendar.Component], _ calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, _ calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    // Update days in Date
    func updateDate(by days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self)
    }

    func computeNewDate(from fromDate: Date, to toDate: Date) -> Date {
        let delta = toDate.timeIntervalSince(fromDate)
        let today = Date()
        if delta < 0 {
            return today
        } else {
            return today.addingTimeInterval(delta)
        }
    }

    var getSecondDifferenceFromCurrent: Int {
        return Int(Date.now.distance(to: self))
    }

    // get String
    var timeIn12Hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        let result = dateFormatter.string(from: self)
        return result
    }
}

extension Date {
    static func getStringFromSecond(_ second: Int, allowedUnit: NSCalendar.Unit = [.day, .hour, .minute]) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = allowedUnit
        formatter.unitsStyle = .full

        let formattedString = formatter.string(from: TimeInterval(second))
        return formattedString
    }
}
