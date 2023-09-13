//
//  AlarmEntity.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/27/23.
//

import Foundation
import CoreData

@objc(AlarmEntity)
class AlarmEntity: NSManagedObject {
}

extension AlarmEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmEntity> {
        return NSFetchRequest<AlarmEntity>(entityName: "AlarmEntity")
    }

    @NSManaged public var daysToRing: [Int]
    @NSManaged public var isActive: Bool
    @NSManaged public var isVibrating: Bool
    @NSManaged public var label: String?
    @NSManaged public var timeToRing: Date
    @NSManaged public var volume: Int16
    @NSManaged public var id: UUID

}

extension AlarmEntity: Identifiable {

}
