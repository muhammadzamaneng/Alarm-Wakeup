//
//  SleepViewModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 16/02/2023.
//

import Foundation
import SwiftUI
import Combine

class CategoryViewModel: ObservableObject {
    typealias Dependencies = HasMusicService

    @EnvironmentObject var coordinator: DashboardCoordinator
    @Published var musicService: MusicService
    var cancellable: AnyCancellable?

    @Published var categories: [CategoryModel] = [] {
        willSet {
            if let category = newValue.first {
                setSelectedSound(category.id, category.selectedSound)
            }
        }
    }

    init(dependencies: Dependencies = AppDependencies.shared) {
        self.musicService = dependencies.musicService
        cancellable = self.musicService.$selectedSound.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        fetchSounds()
    }

    func isCategorySelected(id categoryId: Int) -> Bool {
        return musicService.selectedSound?.categoryId == categoryId
    }

}

// View Builder

extension CategoryViewModel {

    @ViewBuilder
    func getViewForSound(_ categoryAt: Int) -> some View {
        let viewModel = SoundsViewModel(category: categories[categoryAt])
        SoundsView(viewModel: viewModel)
    }
}

// Featch Data

extension CategoryViewModel {
    private func fetchSounds() {
        categories = CategoryModel.sampleData
    }

    private func setSelectedSound(_ categoryId: Int, _ sound: SoundModel) {
        musicService.selectSound(categoryId: categoryId, sound: sound)
    }
}

// Playing

extension CategoryViewModel {
    var isPlaying: Bool {
        musicService.isPLaying
    }

    func mainPlayBtn() {
        if isPlaying {
            musicService.stopSound()
        } else {
            do {
                try musicService.playSound()
            } catch {
                print("ERROR: something went gonr \(error)")
            }
        }
        objectWillChange.send()
    }
}
