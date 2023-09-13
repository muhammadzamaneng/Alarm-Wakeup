//
//  DashboardCoordinator.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/02/2023.
//

import SwiftUI

final class DashboardCoordinator: ObservableObject, Coordinator {

    @Published var path: NavigationPath
    var parentCoordinator: Coordinator?
    var childern: [Coordinator]
    var state: State

    init(parentCoordinator: Coordinator?) {
        self.state = .alarm
        self.path = NavigationPath()
        self.parentCoordinator = parentCoordinator
        self.childern = []
    }

//    @ViewBuilder
    func getTabBarView(for state: State) -> some View {
        return getStateView(for: state)
    }

    @ViewBuilder
    private var stateBody: some View {
        getStateView(for: self.state)
    }

    // MARK: Navigation functions

    @ViewBuilder
    private func getStateView(for state: State) -> some View {
        switch state {
        case .alarm:
            alarm
        case .sleep:
            sleep
        case .record:
            setting
        case .news:
            setting
        case .settings:
            setting
        }
    }

    // MARK: Navigation functions

    lazy var alarm: some View = {
        let viewModel = AlarmViewModel()
        return AlarmView(viewModel: viewModel)
    }()

    lazy var sleep: some View = {
        let viewModel = CategoryViewModel()
        return CategoryView(viewModel: viewModel)
    }()

    lazy var setting: some View = {
        let viewModel = SettingsViewModel()
        return SettingsView(viewModel: viewModel)
    }()

//    @ViewBuilder
//    private func goToHome() -> some View {
//        let viewModel = AlarmViewModel()
//        return AlarmView(viewModel: viewModel)
//    }
//
//    @ViewBuilder
//    private func goToSleep() -> some View {
//        let viewModel = CategoryViewModel()
//        CategoryView(viewModel: viewModel)
//    }
//
//    @ViewBuilder
//    private func goToSetting() -> some View {
//        SettingsView()
//    }

}

// MARK: State

extension DashboardCoordinator {

    // Make this case to CaseIterable to use this in Foreach
    // Identifiable to set self and a id insted of self.rawValue
    // String used to use rawValue in id for ForEach
    // Another purpose it can be used as navigation Title or Tab Bar item with Text
    enum State: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }

        case alarm = "Alarm"
        case sleep = "Sleep"
        case record = "Record"
        case news = "News"
        case settings = "Settings"

        // For TabBarItem Icon
        var image: Image {
            switch self {
            case .alarm: return Image(systemName: ASR.clockIcon)
            case .sleep: return Image(systemName: "moon.stars")
            case .record: return Image(systemName: "chart.xyaxis.line")
            case .news: return Image(systemName: "newspaper")
            case .settings: return Image(systemName: "gearshape")
            }
        }
    }
}
