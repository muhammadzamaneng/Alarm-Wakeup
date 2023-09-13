//
//  ImageHelperView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 16/02/2023.
//

import SwiftUI

struct ImageHelperView: View {
    let image: String
    let imageType: ImageType

    init(_ image: String, imageType: ImageType = .systemImage) {
        self.image = image
        self.imageType = imageType
    }

    var body: some View {
        switch imageType {
        case .image:
            Image(image)
                .resizable()
        case .systemImage:
            Image(systemName: image)
        case .urlImage:
            if let url = URL(string: image) {
                AsyncImage(url: url)
                { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

enum ImageType {
    case image
    case systemImage
    case urlImage
}

struct ImageHelperView_Previews: PreviewProvider {
    static var previews: some View {
        ImageHelperView("photo")
    }
}
