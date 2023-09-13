//
//  ResponsivePreviewDevice.swift
//  Alarm-Wakeup
//
//  Created by Dev on 16/02/2023.
//

import SwiftUI

class ResponsivePreviewDevice {

    static let device = ["iPhone 14 Pro Max", "iPad Pro (12.9-inch) (6th generation)"]

    @ViewBuilder
    static func preview(content: some View) -> some View {
        content
            .previewDevice(PreviewDevice(rawValue: device[0]))
            .previewDisplayName(device[0])

        content
            .previewDevice(PreviewDevice(rawValue: device[0]))
            .previewDisplayName(device[0])
            .previewInterfaceOrientation(.landscapeLeft)

        content
            .previewDevice(PreviewDevice(rawValue: device[1]))
            .previewDisplayName(device[1])
    }
}
