//
//  SoundItemView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 08/03/2023.
//

import SwiftUI

struct SoundItemView: View {
    let sound: SoundModel
    let size: CGSize
    var selected: Bool = false
    var playing: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    ImageHelperView(sound.imageURL, imageType: .image)
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .framePec(size: size, heightPec: 30)
                        .cornerRadius(10)
                    .shadow(color: Color.primary.opacity(0.3), radius: 1)
                    if selected && playing {
                        AudioVisualization(width: 4)
                            .foregroundColor(.white)
                    }
                }
                if selected {
                    ImageHelperView("checkmark.circle.fill")
                        .foregroundStyle(.white, Color.awSoundSelectedColor)
                        .font(.title3)
                        .padding([.trailing, .top], 10)
                }
            }
            Text(sound.title)
                .font(.awTitleForSoundsFont)
            Text(sound.subtitle)
                .foregroundColor(.awSubTitleForSoundsColor)
                .font(.awSubTitleForSoundsFont)
        }
    }
}

struct SoundItemView_Previews: PreviewProvider {
    static let sound = SoundModel.sampleData.first!
    static var previews: some View {
        GeometryReader { matric in
            SoundItemView(sound: sound, size: matric.size, selected: true)
        }.padding()

    }
}
