//
//  SoundModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 24/02/2023.
//

import Foundation

struct CategoryModel: Identifiable {
    let id: Int
    let imageUrl: String
    let title: String
    let decription: String
    var selectedSoundAt: Int = 0
    var soundList: [SoundModel]

    var selectedSound: SoundModel {
        soundList[selectedSoundAt]
    }

    func isSoundSelected(at index: Int) -> Bool {
        return selectedSoundAt == index
    }

    mutating func soundSelected(_ index: Int) {
        if index >= 0 && index < soundList.count {
            selectedSoundAt = index
        }
    }
}

// MARK: - Preview Data
extension CategoryModel {
    static var sampleData: [CategoryModel] {
        [
            CategoryModel(id: 0, imageUrl: "https://as1.ftcdn.net/v2/jpg/01/63/29/14/1000_F_163291409_Fc6CPBGBSjqEvjkeamC6m66kpshzI4BN.jpg", title: "Sleep Sounds", decription: "Light Rain", soundList: SoundModel.sampleData),
            CategoryModel(id: 1, imageUrl: "https://as1.ftcdn.net/v2/jpg/01/63/29/14/1000_F_163291409_Fc6CPBGBSjqEvjkeamC6m66kpshzI4BN.jpg", title: "Sleep Sounds", decription: "Light Rain", soundList: SoundModel.sampleData)
        ]
    }
}
