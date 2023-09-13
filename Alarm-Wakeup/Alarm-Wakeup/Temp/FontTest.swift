//
//  Font.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/10/23.
//

import SwiftUI

struct FontTest: View {
    var body: some View {
        VStack {
            Text("Hello Large Title")
                .font(.largeTitle)

            Text("Hello Title 1")
                .font(.title)

            Text("Hello Title 2")
                .font(.title2)

            Text("Hello Title 3")
                .font(.title3)

            Text("Hello Headline")
                .font(.headline)

            Text("Hello Subheadline")
                .font(.subheadline)

            Text("Hello Body")
                .font(.body)

            Text("Hello Callout")
                .font(.callout)

            Text("Hello Footnote")
                .font(.footnote)

            Group {
                Text("Hello caption1")
                    .font(.caption)

                Text("Hello caption2")
                    .font(.caption2)
            }
        }
    }
}

struct Font_Previews: PreviewProvider {
    static var previews: some View {
        FontTest()
    }
}
