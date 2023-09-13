//
//  SleepSounds.swift
//  Alarm-Wakeup
//
//  Created by Dev on 27/02/2023.
//

import SwiftUI

struct SoundsView: View {
    @StateObject var viewModel: SoundsViewModel
    @State var isBottomSheetShowing = false

    @State var gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack {
            GeometryReader { matric in
                ScrollView {
                    LazyVGrid(columns: gridLayout, alignment: .center, spacing: 20) {
                        ForEach(0...100, id: \.self) { index in
                            let sound = viewModel.sounds[index%3]
                            Button {
                                viewModel.soundSelected(at: index)
                            } label: {
                                SoundItemView(
                                    sound: sound,
                                    size: matric.size,
                                    selected: viewModel.isSoundSelected(at: index),
                                    playing: viewModel.isSoundPlaying(sound)
                                )
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .floatingView(body: HStack {
                Button {
                    isBottomSheetShowing.toggle()
                } label: {
                    ImageHelperView("stopwatch.fill")
                    Text("Sound Timer")
                    Spacer()
                    Text("\(viewModel.getTimer) m")
                    ImageHelperView("chevron.right")
                        .font(.title3.weight(.bold))
                }
                .foregroundColor(Color.primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(Color.awTosterColor.opacity(0.9))
                .cornerRadius(10)
                .padding(.horizontal)
            })
            .sheet(isPresented: $isBottomSheetShowing) {
                TimerView(selectedTime: $viewModel.timer) {
                    isBottomSheetShowing.toggle()
                }
                .presentationDetents([.fraction(0.3), .medium])
            }
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 3 + 1)
                    } label: {
                        Image(systemName: "square.grid.2x2")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct SleepSounds_Previews: PreviewProvider {
    static var viewModel = SoundsViewModel(category: CategoryModel.sampleData.first!)

    static var previews: some View {
        ResponsivePreviewDevice.preview(content: SoundsView(viewModel: viewModel))
    }
}
