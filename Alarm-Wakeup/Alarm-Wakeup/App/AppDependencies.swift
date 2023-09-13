//
//  AppDependencies.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/13/23.
//

import Foundation

class AppDependencies: HasLocalStorageService, HasAlarmService, HasMusicService, HasNotificationService {
    static let shared = AppDependencies()

    lazy var localStorageService: LocalStorageService = LocalStorageService(containerName: "AlarmContainer")
    lazy var alarmService: AlarmService = AlarmService()
    lazy var musicService: MusicService = MusicService()
    lazy var notificationService: NotificationService = NotificationService()
}
