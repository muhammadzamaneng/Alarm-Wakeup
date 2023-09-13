//
//  ListItemWidget.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/20/23.
//

import SwiftUI

struct ListItemWidget<LeadingView: View, ContentView: View, SubView: View, TrailingView: View>: View {
    let leadingView: LeadingView
    let contentView: ContentView
    let subView: SubView
    let trailingView: TrailingView

    init(leadingView: () -> LeadingView = { return EmptyView() }, @ViewBuilder contentView: () -> ContentView, @ViewBuilder subView: () -> SubView, @ViewBuilder trailingView: () -> TrailingView) {

        self.leadingView = leadingView()
        self.contentView = contentView()
        self.subView = subView()
        self.trailingView = trailingView()
    }

    var body: some View {
        HStack {
            HStack {
                leadingView
                VStack(alignment: .leading) {
                    contentView
                    subView
                }
            }.padding(.vertical, 5)
            Spacer()
            trailingView
        }
    }
}

struct ListItemWidget_Previews: PreviewProvider {
    static var previews: some View {
        ListItemWidget {
            Text("Title")
        } subView: {
            Text("Subtitle")
        } trailingView: {
            Text("Trailing")
        }

        ListItemWidget {
            Text("Trailing")
        } contentView: {
            Text("Title")
        } subView: {
            Text("Subtitle")
        } trailingView: {
            Text("Trailing")
        }
    }
}
