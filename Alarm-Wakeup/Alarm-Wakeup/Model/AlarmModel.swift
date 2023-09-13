//
//  AlaramModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/22/23.
//

import SwiftUI
import CoreData

struct AlarmModel: Identifiable, Codable {
    static let maxVolume: Double = 15

    var id: UUID = UUID()
    var timeToRing: Date
    var daysToRing: Set<Days>
    var selectedVolume: Double
    var isVibrating: Bool
    var label: String?
    var isActive: Bool

    var daysToRingInNumber: [Int] {
        Days.daysToIntegers(days: daysToRing)
    }

    var daysToRingCount: Int {
        daysToRing.count
    }

    init(date: Date = Calendar.current.date(byAdding: .minute, value: 1, to: Date.now) ?? Date.now, selectedDays: Set<Days> = Days.weekdays, selectedVolume: Double = Self.maxVolume, isVibrating: Bool = true, isActive: Bool = true) {
        self.timeToRing = date
        self.daysToRing = selectedDays
        self.selectedVolume = selectedVolume
        self.isVibrating = isVibrating
        self.isActive = isActive
    }

    var isValidate: Bool {
        return true
    }
}

// Repeat days Processing

extension AlarmModel {
    mutating func repeatEveryDaySet(_ repeatEveryDay: Bool) {
        if repeatEveryDay {
            daysToRing = Set(Days.allCases)
        } else {
            daysToRing = Days.weekdays
        }
    }
}

// Days selection Processing

extension AlarmModel {

    func isDaySelected(_ day: Days) -> Bool {
        return daysToRing.contains(day)
    }

    mutating func selectedDaysToggle(_ day: Days) {
        if daysToRing.remove(day) == nil || daysToRing.isEmpty {
            daysToRing.insert(day)
        }
    }
}

// Label Processing

extension AlarmModel {

    var isLabelValidated: Bool {
        return label == nil ? false : !(label!.isEmptyWithTrim)
    }

    func setLabelCallback(label: String) -> String? {
        let value = label.trimmingCharacters(in: .whitespacesAndNewlines)
        if value.isEmpty {
            return nil
        }
        return value
    }
}

// CoreDataCodable
extension AlarmModel: CoreDataCodable {
    static func from(fromCoreData: NSManagedObject) {
    }

    static func fromCoreData(entities: [AlarmEntity]) -> [Self] {
        entities.compactMap { AlarmModel(from: $0) }
    }

    init?(from coreDataEntity: AlarmEntity) {
        self.id = coreDataEntity.id
        self.timeToRing = coreDataEntity.timeToRing
        self.daysToRing = Days.integersToDays(coreDataEntity.daysToRing)
        self.selectedVolume = Double(coreDataEntity.volume)
        self.isVibrating = coreDataEntity.isVibrating
        self.label = coreDataEntity.label
        self.isActive = coreDataEntity.isActive
    }

    func toCoreDataEntity(context: NSManagedObjectContext) -> NSManagedObject {
        let newAlarm = AlarmEntity(context: context)
        newAlarm.id = id
        newAlarm.timeToRing = timeToRing
        newAlarm.daysToRing = daysToRingInNumber
        newAlarm.volume = Int16(selectedVolume)
        newAlarm.isVibrating = isVibrating
        newAlarm.label = label
        newAlarm.isActive = isActive
        return newAlarm
    }
}

// MARK: - Preview Data
extension AlarmModel {
    static var sampleData: [AlarmModel] {
        [
            AlarmModel(),
            AlarmModel()
        ]
    }
}
