//
//  SoundModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 27/02/2023.
//

import Foundation

struct SoundModel: Identifiable, Equatable {
    let id: Int
    let title: String
    let subtitle: String
    let imageURL: String
    let url: String
    let categoryId: Int

    static func == (lhs: SoundModel, rhs: SoundModel) -> Bool {
        return (lhs.id == rhs.id)
    }
}

// MARK: - Preview Data
extension SoundModel {
    static var sampleData: [SoundModel] {
        [
            SoundModel(id: 0, title: "Sleep Sounds", subtitle: "Alarmy", imageURL: "Sounds_Img/1", url: "Sleep/1", categoryId: 0),
            SoundModel(id: 1, title: "Medium Rails", subtitle: "Alarmy", imageURL: "Sounds_Img/2", url: "Sleep/1", categoryId: 0),
            SoundModel(id: 2, title: "Fireplace", subtitle: "Alarmy", imageURL: "Sounds_Img/3", url: "Sleep/1", categoryId: 0)
        ]
    }
}
