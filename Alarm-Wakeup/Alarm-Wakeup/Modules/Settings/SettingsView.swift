//
//  SettingsView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 16/02/2023.
//

import SwiftUI

struct SettingsView: View {
  @ObservedObject var viewModel: SettingsViewModel
  var body: some View {
    GeometryReader { metrics in
      VStack(alignment: .leading) {
        SettingsHeading()
        Spacer()
        SettingsOptionsList(viewModel: viewModel, size: metrics.size)
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = SettingsViewModel()
    return SettingsView(viewModel: viewModel)
  }
}

struct SettingsOptionButton: View {
  @ObservedObject var viewModel: SettingsViewModel
  let data: SettingsViewModel.State
  let size: CGSize
  var body: some View {
    NavigationLink(destination: { viewModel.getViewForSelectedOption(for: data) }) {
      HStack {
        data.image
          .foregroundColor(data.rawValue == "Premium" ? .awPremiumLabelColor : .awTabBarItemColor)
          .font(.awDescriptionFont)
          .bold()
          .framePec(size: size, widthPec: 9, heightPec: 9)
        Text(data.rawValue)
          .font(.awDescriptionFont)
          .foregroundColor(.awTabBarItemColor)
      }
      .framePec(size: size, heightPec: 10)
    }
  }
}

struct SettingsOptionsList: View {
  @ObservedObject var viewModel: SettingsViewModel
  let size: CGSize
  var body: some View {
    VStack(spacing: 0.0) {
      List {
        Section(header: Spacer(minLength: 0)) {
          ForEach(SettingsViewModel.State.premiumCategory, id: \.id) { state in
            SettingsOptionButton(viewModel: viewModel, data: state, size: size)
          }
        }
        Section {
          ForEach(SettingsViewModel.State.localCategory, id: \.id) { state in
            SettingsOptionButton(viewModel: viewModel, data: state, size: size)
          }
        }
      }
      .listStyle(.grouped)
      .scrollContentBackground(.hidden)
      .scrollDisabled(true)
      .environment(\.defaultMinListHeaderHeight, 0)
    }
  }
}

struct SettingsHeading: View {
  var body: some View {
    HStack {
      Text("More")
        .font(.awListAlarmItemTimeFont)
    }
    .padding(.all)
  }
}
