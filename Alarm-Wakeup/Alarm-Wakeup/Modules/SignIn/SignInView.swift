//
//  SignIn.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/04/2023.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
      GeometryReader { metrics in
        VStack {
          Spacer()
          DescriptionDetails(size: metrics.size)
          Spacer()
          SignUpButton()
          AppleAgreement()
        }
      }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
      SignInView()
    }
}

struct AppleAgreement: View {
  var body: some View {
    Text("By proceeding, you are agreeing to our \(Text("Terms & Conditions").underline()) and \(Text("Privacy Policy").underline()).")
      .font(.awSubheadlineFont)
      .padding(.horizontal)
      .padding()
  }
}

struct SignUpButton: View {
  var body: some View {
    Button {
    } label: {
      HStack {
        Image(systemName: "apple.logo")
          .foregroundColor(.awTabBarItemColor)
          .font(.awTitle2BoldFont)
          .padding(.leading)
        Text("Continue with Apple")
          .font(.awTitle2)
          .foregroundColor(.awTabBarItemColor)
          .padding(.trailing)
      }
      .padding(.horizontal)
    }
    .padding()
    .padding(.horizontal)
    .background(Color(.systemGray5))
    .cornerRadius(10)
  }
}

struct DescriptionDetails: View {
  let size: CGSize
  var body: some View {
    VStack {
      HStack {
        Spacer()
        ImageHelperView("Signup", imageType: .image)
          .font(.awSubTitleForSoundsFont)
          .framePec(size: size, widthPec: 50, heightPec: 50)
          .aspectRatio(contentMode: .fit)
        Spacer()
      }
      Text("Create Your Own Alarmy Account!")
        .font(.awTitleBoldFont)
        .foregroundColor(.awTabBarItemColor)
        .multilineTextAlignment(.center)
        .padding()
      Text("You'll be the first to learn about improved features.")
        .font(.awTitle3)
        .foregroundColor(.awTabBarItemColor)
        .multilineTextAlignment(.center)
        .padding()
    }
  }
}
