//
//  SettingsViewModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 04/04/2023.
//

import Foundation
import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
  @EnvironmentObject var coordinator: DashboardCoordinator
  var state: State
  init() {
    self.state = .premium
  }
}

// MARK: New Screen

extension SettingsViewModel {
  @ViewBuilder
  func getViewForSelectedOption(for state: State) -> some View {
    getStateView(for: state)
  }
  @ViewBuilder
  private func getStateView(for state: State) -> some View {
      switch state {
      case .premium:
        PremiumSignUpView()
      case .restorePurchases:
        AboutView()
      case .signIn:
        SignInView()
      case .optimizeUseablity:
        AboutView()
      case .notices:
        AboutView()
      case .faq:
        AboutView()
      case .sendFeedback:
        AboutView()
      case .about:
        AboutView()
      }
  }
}

// MARK: State

extension SettingsViewModel {

    // Make this case to CaseIterable to use this in Foreach
    // Identifiable to set self and a id insted of self.rawValue
    // String used to use rawValue in id for ForEach
    // Another purpose it can be used as navigation Title or Tab Bar item with Text
    enum State: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }

        case premium = "Premium"
        case restorePurchases = "Restore Purchases"
        case signIn = "Sign In"
        case optimizeUseablity = "Optimize Useablity"
        case notices = "Notices"
        case faq = "FAQ"
        case sendFeedback = "Send Feedback"
        case about = "About"

        static let premiumCategory: [State] = [.premium, .restorePurchases]
        static let localCategory: [State] = [.signIn, .optimizeUseablity, .notices, .faq, .sendFeedback, .about]
        var image: Image {
            switch self {
            case .premium: return Image(systemName: "crown.fill")
            case .restorePurchases: return Image(systemName: "arrow.clockwise")
            case .signIn: return Image(systemName: "person.fill.badge.plus")
            case .optimizeUseablity: return Image(systemName: "list.clipboard.fill")
            case .notices: return Image(systemName: "speaker.fill")
            case .faq: return Image(systemName: "questionmark.circle.fill")
            case .sendFeedback: return Image(systemName: "paperplane.fill")
            case .about: return Image(systemName: "info.circle.fill")
            }
        }
    }
}
