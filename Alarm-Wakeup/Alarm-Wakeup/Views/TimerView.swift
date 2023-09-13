//
//  TimerView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/14/23.
//

import SwiftUI

struct TimerView: View {
    var timer = PlayTime.allCases
    @Binding var selectedTime: PlayTime
    let action: (() -> Void)

    var body: some View {
        VStack {
            Text("Sound Timer")
                .font(.largeTitle)
            Picker("Sound Timer", selection: $selectedTime) {
                ForEach(timer, id: \.self) { min in
                    Text("\(min.rawValue) min")
                }
            }
            .pickerStyle(.inline)
            Button {
                action()
            } label: {
                Text("SAVE")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.primary)
            .tint(Color.awTosterColor)
            .controlSize(.large)
        }
        .padding()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(selectedTime: Binding<PlayTime>.constant(.defaultTimer)) {}
    }
}
