// swiftlint:disable comment_spacing
////
////  NSCollectionIntTransfoer.swift
////  Alarm-Wakeup
////
////  Created by Dev on 3/26/23.
////
//
// import Foundation
//
// class NSCollectionTransformer: ValueTransformer {
//    override func transformedValue(_ value: Any?) -> Any? {
//        guard let col = value as? NSArray else { return nil }
//
//        do {
//            return try NSKeyedArchiver.archivedData(withRootObject: col, requiringSecureCoding: true)
//        } catch {
//            print("Debug: Error while NSCollectionIntTransformer \(error)")
//            return nil
//        }
//    }
//
//    override func reverseTransformedValue(_ value: Any?) -> Any? {
//        guard let data = value as? Data else { return nil }
//
//        do {
//            return try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSNumber.self], from: data)
//        } catch {
//            print("Debug: Error while reverseTransformedValue \(error)")
//            return nil
//        }
//    }
//}
