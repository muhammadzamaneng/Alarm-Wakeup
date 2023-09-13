//
//  Binding+Extensions.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/24/23.
//

import SwiftUI

// swiftlint:disable syntactic_sugar

extension Binding {

    func toUnwrapped<T>(defaultValue: T, setCallback: @escaping (T) -> T? = { return $0 }) -> Binding<T> where Value == Optional<T> {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = setCallback($0) })
    }
}
