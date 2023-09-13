//
//  AppCoordinator.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/02/2023.
//

import SwiftUI

final class AppCoordinator: ObservableObject, Coordinator {
    var state: State
    @Published var path = NavigationPath()
    var parentCoordinator: Coordinator?
    var childern: [Coordinator]

    init() {
        self.state = .dashboard
        self.path = NavigationPath()
        self.childern = []
    }

    @ViewBuilder
    var stateBody: some View {
        switch state {
        case .dashboard:
            goToDashboard()
        }
    }

    // MARK: Navigation functions

    func goToDashboard() -> some View {
        let coordinator = DashboardCoordinator(parentCoordinator: self)
        childern.append(coordinator)
        return DashboardCoordinatorView(coordinator: coordinator)
    }
}

// MARK: - State

extension AppCoordinator {
    enum State {
        case dashboard
    }
}
