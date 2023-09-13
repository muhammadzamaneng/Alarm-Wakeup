//
//  Font+Extensions.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/10/23.
//

import SwiftUI

extension Font {
    static let awTitleForSoundsFont: Font = Font.subheadline
    static let awSubTitleForSoundsFont: Font = Font.caption

    // MARK: - Alaram Screen
    static let awListTitleFont: Font = .title3.weight(.medium)
    static let awListAlarmItemTimeFont: Font = .largeTitle.weight(.bold)
    static let awListAlarmItemFont: Font = .subheadline.weight(.medium)

    // MARK: - Common
    static let awTitle2BoldFont: Font = .title2.weight(.bold)
    static let awDescriptionFont: Font = .body
  
    // MARK: - Title Font
    static let awTitleBoldFont: Font = .title.weight(.bold)
    static let awTitle2: Font = .title2
    static let awSubheadlineFont: Font = .subheadline
    static let awTitle3: Font = .title3
    static let awPremiumFeatures: Font = .callout

}
