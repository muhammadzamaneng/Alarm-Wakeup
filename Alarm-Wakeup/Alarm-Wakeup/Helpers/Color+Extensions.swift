//
//  Color+Extensions.swift
//  Alarm-Wakeup
//
//  Created by Dev on 09/02/2023.
//

import SwiftUI

extension Color {
    static var awSwitchBackground: Color = Color("SwitchBackground")
    static var awTabBarItemColor: Color = Color.primary
    static let awSubTitleForSoundsColor: Color = Color(.gray).opacity(0.8)
    static let awSecondaryColor: Color = Color("SecondaryColor")
    static let awSoundSelectedColor: Color = Color.cyan
    static let awTosterColor: Color = Color("TosterColor")

    // MARK: - Alaram Screen
    static let awFloatingButtonColor: Color = Color("FloatingActionColor")
    static let awSelectedItemColor: Color = Color("SelectedItemColor")

    // MARK: - Permissions
    static let awNotificationPerBtnColor: Color = Color("NotificationPerBtnColor")

    // MARK: - Common
    static let awLabelColor: Color = Color(uiColor: .label)
    // MARK: - Premium
    static let awPremiumLabelColor: Color = Color(uiColor: .red)
    static let awPremiumTrialFontColor: Color = Color.white
    static let awPremiumPaymentDetails: Color = Color(.systemGray2)
}
