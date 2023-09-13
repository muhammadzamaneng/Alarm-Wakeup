//
//  TimerModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/14/23.
//

import Foundation

enum PlayTime: Int, CaseIterable {
    case m30 = 30
    case m60 = 60
    case m90 = 90

    static let defaultTimer = Self.m60
}
