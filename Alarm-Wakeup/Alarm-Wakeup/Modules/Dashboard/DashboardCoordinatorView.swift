//
//  DashboardCoordinatorView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/02/2023.
//

import SwiftUI

struct DashboardCoordinatorView: View {
    @ObservedObject var coordinator: DashboardCoordinator
    var all: [DashboardCoordinator.State] = [.alarm, .news, .record, .news, .settings]

    init(coordinator: DashboardCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                TabView {
                    ForEach(DashboardCoordinator.State.allCases, id: \.id) { state in
                        tabContent(for: state)
                            .tabItem {
                                state.image
                            }
                    }
                }
                .tint(Color.awTabBarItemColor)
            }
        }
        .environmentObject(coordinator)
    }

    func tabContent(for state: DashboardCoordinator.State) -> some View {
//        print("1 Called on State \(state)")
       return coordinator.getTabBarView(for: state)
    }
}

struct DashboardCoordinatorView_Previews: PreviewProvider {
    static var coordinator = DashboardCoordinator(parentCoordinator: nil)
    static var previews: some View {
        NavigationStack {
            DashboardCoordinatorView(coordinator: coordinator)
        }
    }
}
