//
//  SleepView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 16/02/2023.
//

import SwiftUI

struct CategoryView: View {
    @Namespace var namespace
    @StateObject var viewModel: CategoryViewModel

    var body: some View {
        NavigationStack {
            GeometryReader { metrics in
                List {
                    Section {
                        ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { index, category in
                            HStack {
                                ListItemView(
                                    model: category,
                                    size: metrics.size,
                                    isSelected: viewModel.isCategorySelected(id: category.id)
                                )
                            }
                            .background(
                                NavigationLink(destination: {
                                    viewModel.getViewForSound(index)
                                }, label: {
                                    EmptyView()
                                })
                                .opacity(0)
                            )
                        }
                    }
                    Section {
                        VStack(spacing: 20) {
                            ImageHelperView(
                                "sleep_sound_center_img",
                                imageType: .image
                            )
                            .framePec(size: metrics.size, widthPec: 50, heightPec: 37.5)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Capsule())
                            .clipped()
                            Text("Fall asleepfast with\npeaceful sounds")
                                .multilineTextAlignment(.center)
                            Button(action: viewModel.mainPlayBtn) {
                                HStack {
                                    Text("Start")
                                    ImageHelperView(viewModel.isPlaying ? "pause.fill" : "play.fill")
                                }
                                .font(.headline)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.top, 10)
                        }
                        .framePec(size: metrics.size, widthPec: 50)
                    }
                    .listRowBackground(Color.clear)
                    .frame(width: metrics.size.width, alignment: .center)
                }
            }
            .navigationTitle("Sleep")
        }
    }
}

struct SleepView_Previews: PreviewProvider {
    static var viewModel = CategoryViewModel()
    static var previews: some View {
        ResponsivePreviewDevice.preview(content: CategoryView(viewModel: viewModel))
    }
}
