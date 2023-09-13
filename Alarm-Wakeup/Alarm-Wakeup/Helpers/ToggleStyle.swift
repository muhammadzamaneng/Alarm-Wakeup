//
//  ToggleStyle.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/17/23.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    let selectedColor: Color
    let unSelectedColor: Color
    let size: Double
    let leftSide: Bool

    init(selectedColor: Color = .blue, unSelectedColor: Color = .gray, size: Double = 24, leftSide: Bool = true) {
        self.selectedColor = selectedColor
        self.unSelectedColor = unSelectedColor
        self.size = size
        self.leftSide = leftSide
    }

    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            if leftSide {
                configuration.label
            }
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(configuration.isOn ? selectedColor : unSelectedColor)
                .padding(.horizontal, 5)
            if !leftSide {
                configuration.label
            }
        }
        .onTapGesture { configuration.isOn.toggle() }
    }
}
