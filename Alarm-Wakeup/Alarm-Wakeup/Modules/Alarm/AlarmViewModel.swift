//
//  HomeViewModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/02/2023.
//

import SwiftUI
import CoreData

class AlarmViewModel: ObservableObject {
    typealias Dependencies = HasLocalStorageService & HasNotificationService

    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var coordinator: DashboardCoordinator
    @Published var requiredPermission: Bool {
        didSet {
            if requiredPermission {
                permissionDialog = requiredPermission
            }
        }
    }
    var localStorageService: LocalStorageService
    var notificationService: NotificationService
    @Published var alarms: [AlarmModel]

    @Published var permissionDialog: Bool

    init(dependencies: Dependencies = AppDependencies.shared, alarms: [AlarmModel] = []) {
        self.requiredPermission = false
        self.permissionDialog = false
        self.localStorageService = dependencies.localStorageService
        self.notificationService = dependencies.notificationService
        self.alarms = alarms
        checkPermission()
        fetchAlarm()
    }
}

// For Alarm View Item List

extension AlarmViewModel {

    func getAlarmActiveBinding(_ alarmIndex: Int, _ alarm: AlarmModel) -> Binding<Bool> {
        return Binding {
            alarm.isActive
        } set: { [weak self] value in
            self?.toggleAlarmActive(alarmIndex, alarm, value)
        }
    }

    func getAlarmMission(_ alarm: AlarmModel) -> String {
        guard let label = alarm.label else { return "None" }
        return "Mission | \(label)!"
    }

    func getDaysToRing(_ alarm: AlarmModel) -> String {
        return Days.daysDecription(days: alarm.daysToRing)
    }
}

// MARK: - Local Storage

extension AlarmViewModel {

    func fetchAlarm() {
        print("Debug: fetchAlarm called")
        localStorageService.fetchData(entity: AlarmEntity.self) { [weak self] result in
            switch result {
            case .success(let alarmEntities):
                self?.alarms = AlarmModel.fromCoreData(entities: alarmEntities)
            case .failure(let error):
                print("Error while getting \(error)")
            }
        }
    }

    func toggleAlarmActive(_ alarmIndex: Int, _ alarm: AlarmModel, _ value: Bool) {
        localStorageService.updateData(id: alarm.id, value: value) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    self?.updateAlarmActiveStatus(alarmIndex, value)
                }
            case .failure(let error):
                print("Failed to update value \(error)")
            }
        }
    }

    func updateAlarmActiveStatus(_ alarmIndex: Int, _ value: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.alarms[alarmIndex].isActive = value
        }
    }
}

// MARK: - Permission

extension AlarmViewModel {

    func checkPermission() {
        Task {
            print("read again permission")
            let granted = await notificationService.requestNotifcation()
            if !granted {
                self.requiredPermission = true
            }
        }
    }

    func permissionConfirm() {
        notificationService.openSetting()
    }
}

// MARK: - View Builders
extension AlarmViewModel {

    @ViewBuilder
    func createAlarmView() -> some View {
        let viewModel = AlarmFormViewModel()
        AlarmForm(viewModel: viewModel)
    }
}
