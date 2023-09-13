//
//  NotificationService.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/29/23.
//

import Foundation
import UserNotifications
import SwiftUI

protocol HasNotificationService {
    var notificationService: NotificationService { get }
}

class NotificationService {

    func requestNotifcation() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        } catch let error {
            print("Debug: error while getting permission request \(error)")
            return false
        }
    }

    func openSetting() {
        let url = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
