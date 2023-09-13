//
//  AboutView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 05/04/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
      GeometryReader { metrics in
        VStack {
          Spacer()
          AppDetails(size: metrics.size)
          RateApp()
          AboutOptions(text: "Acknowledgement")
          AboutOptions(text: "Terms & Privacy Policy")
          AboutOptions(text: "Advertising")
          AboutOptions(text: "Ad Personalization")
          Spacer()
          GoBack(size: metrics.size)
          Spacer()
        }
      }
      .navigationBarBackButtonHidden()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

struct AboutOptions: View {
  let text: String
  var body: some View {
    Button {
    } label: {
      Text(text)
        .font(.awDescriptionFont)
        .padding()
        .foregroundColor(Color("BostonBlue"))
    }
  }
}

struct RateApp: View {
  var body: some View {
    Button {
    } label: {
      Text("Rate app")
        .font(.awDescriptionFont)
        .padding(.horizontal)
        .padding(.leading)
        .padding(.trailing)
        .padding()
        .foregroundColor(Color("BostonBlue"))
        .overlay(
          RoundedRectangle(cornerRadius: 50)
            .stroke(Color("BostonBlue"), lineWidth: 2)
        )
    }
    .padding()
  }
}

struct AppDetails: View {
  let size: CGSize
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Image("AppIcon")
          .resizable()
          .framePec(size: size, widthPec: 40, heightPec: 40)
        Spacer()
      }
      HStack {
        Spacer()
        Text("Alarmy")
          .font(.awTitleBoldFont)
        Spacer()
      }
    }
  }
}

struct GoBack: View {
  @Environment(\.presentationMode) var presentationMode
  let size: CGSize
  var body: some View {
    Button {
      self.presentationMode.wrappedValue.dismiss()
    } label: {
      Image(systemName: "x.circle")
        .resizable()
        .fontWeight(.ultraLight)
        .foregroundColor(Color("BostonBlue"))
        .framePec(size: size, widthPec: 13, heightPec: 13)
    }
  }
}
