//
//  SleepSoundsViewModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 27/02/2023.
//

import SwiftUI

class SoundsViewModel: ObservableObject {
    typealias Dependencies = HasMusicService

    @EnvironmentObject var coordinator: DashboardCoordinator
    @Published var category: CategoryModel
    @Published var timer: PlayTime {
        willSet { setTimer(newValue) }
    }

    private let musicService: MusicService

    init(category: CategoryModel, dependencies: Dependencies = AppDependencies.shared) {
        self.category = category
        self.musicService = dependencies.musicService
        self.timer = PlayTime(rawValue: musicService.timer) ?? .defaultTimer
    }

    var title: String {
        category.title
    }

    var sounds: [SoundModel] {
        category.soundList
    }
}

// Timer

extension SoundsViewModel {
    var getTimer: Int {
        musicService.timer
    }

    func setTimer(_ timer: PlayTime) {
        musicService.setTimer(timer: timer)
    }
}

// Sound

extension SoundsViewModel {

    func isSoundSelected(at index: Int) -> Bool {
        return category.isSoundSelected(at: index)
    }

    func isSoundPlaying(_ sound: SoundModel) -> Bool {
        return musicService.isThisPlaying(categoryId: category.id, sound: sound)
    }

    func soundSelected(at index: Int) {
        category.soundSelected(index)
        playSound(sound: category.soundList[index])
    }

    func playSound(sound: SoundModel) {
        do {
            try musicService.selectSoundAndPlay(categoryId: category.id, sound: sound)
        } catch let error {
            print("Error: while playing music -> \(error)")
        }
    }
}
