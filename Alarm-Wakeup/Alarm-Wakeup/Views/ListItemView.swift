//
//  ListItemView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 16/02/2023.
//

import SwiftUI

struct ListItemView: View {
    let model: CategoryModel
    let size: CGSize
    var isSelected: Bool = false

    var body: some View {
        HStack {
            HStack {
                ImageHelperView(
                    model.imageUrl,
                    imageType: .urlImage
                )
                .aspectRatio(contentMode: .fit)
                .framePec(size: size, widthPec: 12, heightPec: 7.98)
                .cornerRadius(5)
                .clipped()
                VStack(alignment: .leading) {
                    Text(model.title)
                        .font(.awTitleForSoundsFont)
                    HStack {
                        Text(model.decription)
                        ImageHelperView("stopwatch.fill")
                        Text("60 m.")
                    }
                    .foregroundColor(.awSubTitleForSoundsColor)
                    .font(.awSubTitleForSoundsFont)
                }
            }.padding(.vertical, 5)
            Spacer()
            if isSelected {
                ImageHelperView("checkmark.circle")
                    .foregroundStyle(Color.green)
                    .font(.title3.weight(.bold))
            } else {
                ImageHelperView("chevron.right.circle")
                    .foregroundStyle(Color.awSecondaryColor)
                    .font(.title3.weight(.bold))
            }
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static let soundModel = CategoryModel.sampleData.first!
    static var previews: some View {
        ResponsivePreviewDevice.preview(content: GeometryReader { matric in
            ListItemView(model: soundModel, size: matric.size)
                .padding()
        })
    }
}
