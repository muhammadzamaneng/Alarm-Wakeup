//
//  View+Estensions.swift
//  Alarm-Wakeup
//
//  Created by Dev on 16/02/2023.
//

import SwiftUI

extension View {

    func framePec(size: CGSize, widthPec: Double? = nil, heightPec: Double? = nil, alignment: Alignment = .center) -> some View {
        return frame(width: widthPec == nil ? nil : (size.width * (widthPec!/100)), height: heightPec == nil ? nil : (size.width * (heightPec!/100)), alignment: alignment)
    }

    func floatingView(body: some View) -> some View {
        self.modifier(FloatingViewModifier(child: body))
    }

    // Create circle background around any object e.g: for Icon with circle button
    func circleBackground(size: CGFloat = 50, foregroundColor: Color = Color(uiColor: .systemBackground), fillColor: Color = Color(uiColor: .label)) -> some View {
        self
            .frame(width: size, height: size)
            .foregroundStyle(foregroundColor)
            .background(Circle().fill(fillColor))
            .shadow(color: Color(uiColor: .secondaryLabel), radius: 2, x: 1, y: 1)
    }

    // Use to apply property conditionally
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) } else { self }
    }

    // Use to create custom placeholder that is show based on condition under the view
    @ViewBuilder
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }

    // Corner Radisu with specfied cornor
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct FloatingViewModifier<FloatingView: View>: ViewModifier {

    @ViewBuilder let child: FloatingView
    let pinned: Bool

    init(child: FloatingView) {
        self.child = child
        self.pinned = true
    }

    init(child: FloatingView, pinned: Bool) {
        self.child = child
        self.pinned = true
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                child
            }
        }
    }
}

// Corner Radisu
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
