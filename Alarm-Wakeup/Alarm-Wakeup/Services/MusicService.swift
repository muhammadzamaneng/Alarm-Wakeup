//
//  MusicService.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/13/23.
//

import Foundation
import AVFoundation
import UIKit

protocol HasMusicService {
    var musicService: MusicService { get }
}

class MusicService: ObservableObject {
    private var player: AVAudioPlayer?
    private(set) var timer: Int = PlayTime.defaultTimer.rawValue
    @Published var selectedSound: SelectedSound?
    var stopTimer: Timer?
}

// Timer

extension MusicService {

    func setTimer(timer: PlayTime) {
        self.timer = timer.rawValue
    }

    private func scheduleTime() {
        resetTimer()
        stopTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timer), repeats: false) {[weak self] _ in
            self?.stopSound()
        }
    }

    private func resetTimer() {
        stopTimer?.invalidate()
        stopTimer = nil
    }
}

// Sound

extension MusicService {

    var isPLaying: Bool {
        player?.isPlaying ?? false
    }

    func isThisPlaying(categoryId: Int, sound: SoundModel) -> Bool {
        return player?.isPlaying == true && selectedSound?.compare(categoryId, sound) ?? false
    }

    func selectSound(categoryId: Int, sound: SoundModel) {
        self.selectedSound = SelectedSound(categoryId: categoryId, soundId: sound.id, soundUrl: sound.url)
    }

    func selectSoundAndPlay(categoryId: Int, sound: SoundModel) throws {
        if selectedSound?.compare(categoryId, sound) ?? false && player?.isPlaying ?? false {
            stopSound()
        } else {
            selectSound(categoryId: categoryId, sound: sound)
            try playSound()
        }
    }

    func playSound() throws {
        try playFromAssets(filename: selectedSound!.soundUrl)
        scheduleTime()
    }

    func stopSound() {
        player?.stop()
        resetTimer()
    }
}

extension MusicService {

    enum AudioLoader {
        case fromResource(URL)
        case fromAsset(NSDataAsset)
    }

    enum AudioLoaderError: Error {
        case resourceNotFound
        case assetNotFound
        case loadPlayer
    }

    func playFromResources(filename: String, fileExtension: String) throws {
        guard let url = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
            throw AudioLoaderError.resourceNotFound
        }
        try playFrom(audioLoader: AudioLoader.fromResource(url))
    }

    func playFromAssets(filename: String) throws {
        guard let dataAsset = NSDataAsset(name: filename) else {
            throw AudioLoaderError.assetNotFound
        }
        try playFrom(audioLoader: AudioLoader.fromAsset(dataAsset))
    }

    func playFrom(audioLoader: AudioLoader) throws {
        switch audioLoader {
        case .fromResource(let url):
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: "wav")
        case .fromAsset(let dataAsset):
            player = try AVAudioPlayer(data: dataAsset.data, fileTypeHint: "wav")
        }
        player?.numberOfLoops = -1
        player?.play()
    }
}

struct SelectedSound {
    var categoryId: Int
    var soundId: Int
    var soundUrl: String

    init(categoryId: Int, soundId: Int, soundUrl: String) {
        self.categoryId = categoryId
        self.soundId = soundId
        self.soundUrl = soundUrl
    }

    func compare(_ categoryId: Int, _ sound: SoundModel) -> Bool {
        return self.categoryId == categoryId && self.soundId == sound.id && self.soundUrl == sound.url
    }
}
