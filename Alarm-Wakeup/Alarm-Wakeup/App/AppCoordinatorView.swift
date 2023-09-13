//
//  ContentView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/02/2023.
//

import SwiftUI

struct AppCoordinatorView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.stateBody
        }
    }
}

struct AppCoordinatorView_Previews: PreviewProvider {
    @State static var coordinator = AppCoordinator()
    static var previews: some View {
        NavigationStack {
            AppCoordinatorView(coordinator: coordinator)
        }
    }
}
