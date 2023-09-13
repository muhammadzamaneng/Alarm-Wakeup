//
//  AudioVisualization.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/13/23.
//

import SwiftUI

struct AudioVisualization: View {
    let width: CGFloat
    let maxHeight: CGFloat
    let numberOfBar: Int
    @State var isVisualizing = false

    init(width: CGFloat = 3.0, maxHeight: CGFloat = 45.0, numberOfBar: Int = 10) {
        self.width = width
        self.maxHeight = maxHeight
        self.numberOfBar = numberOfBar
        self.isVisualizing = isVisualizing
    }

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<numberOfBar, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: width, height: .random(in: isVisualizing ? 3...(maxHeight/2) : 3...maxHeight ))
                    .animation(.easeInOut(duration: 0.25).repeatForever(autoreverses: true), value: isVisualizing)
            }
            .onAppear {
                isVisualizing.toggle()
            }
        }
    }
}

struct AudioVisualization_Previews: PreviewProvider {
    static var previews: some View {
        AudioVisualization()
    }
}
