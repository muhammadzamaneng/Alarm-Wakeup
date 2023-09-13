//
//  Alarm_WakeupApp.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/02/2023.
//

import SwiftUI

@main
struct Alarm_WakeupApp: App {
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: AppCoordinator())
        }
    }
}
