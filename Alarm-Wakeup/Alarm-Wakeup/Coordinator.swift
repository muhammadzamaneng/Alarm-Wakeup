//
//  Coordinator.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/02/2023.
//

import SwiftUI

protocol Coordinator {
    var path: NavigationPath { get set }
    var parentCoordinator: Coordinator? { get set }
    var childern: [Coordinator] { get set }
}
