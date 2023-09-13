//
//  PremiumSignUpView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 14/04/2023.
//

import SwiftUI

struct PremiumSignUpView: View {
    var body: some View {
      GeometryReader { metrics in
        VStack {
          PremiumReviews(size: metrics.size)
          WhyPremium(size: metrics.size)
          Spacer()
          PremiumVersionReasons()
          StartFreeTrialButton()
          FreeTrialDetails()
        }
        .edgesIgnoringSafeArea(.all)
      }
    }
}

struct PremiumSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumSignUpView()
    }
}

struct StartFreeTrialButton: View {
  var body: some View {
    Button {
    } label: {
      HStack {
        Text("Start Free Trial")
          .font(.awTitle2)
          .foregroundColor(.awPremiumTrialFontColor)
          .bold()
          .padding(.leading)
          .padding(.trailing)
          .padding(.horizontal)
      }
      .padding(.horizontal)
    }
    .padding()
    .padding(.horizontal)
    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
    .cornerRadius(40)
  }
}

struct FreeTrialDetails: View {
  var body: some View {
    Text("7 days free, then Rs 1150 /month")
      .font(.awTitle3)
      .foregroundColor(.awPremiumPaymentDetails)
      .multilineTextAlignment(.center)
      .padding()
  }
}

struct WhyPremium: View {
  let size: CGSize
  var body: some View {
    VStack {
      Text("We Wake You Up With Powerful Features")
        .font(.awTitleBoldFont)
        .foregroundColor(.awTabBarItemColor)
        .multilineTextAlignment(.center)
        .padding()
    }
    .padding()
  }
}

struct PremiumReviews: View {
  let size: CGSize
  var body: some View {
    Image("LadyImage")
      .resizable()
      .edgesIgnoringSafeArea(.top)
      .framePec(size: size, widthPec: 100, heightPec: 120)
      .overlay(
        HStack {
          Spacer()
          VStack {
            Spacer()
            Text("Emma, 3-year user of Alarmy")
              .font(.awTitle3)
              .foregroundColor(.awPremiumTrialFontColor)
              .multilineTextAlignment(.center)
              .padding(.horizontal)
              .padding(.top)
            Text("I used to turn off my alarm and fall back asleep. Now, I start my day fresh.")
              .font(.awTitle2)
              .bold()
              .foregroundColor(.awPremiumTrialFontColor)
              .multilineTextAlignment(.center)
              .padding(.horizontal)
              .padding(.bottom)
          }
          Spacer()
        }
      )
  }
}

struct PremiumVersionReasons: View {
  var body: some View {
    HStack {
      Spacer()
      Image(systemName: "square.stack.3d.up.fill")
        .font(.awPremiumFeatures)
        .foregroundColor(.red)
        .padding(.bottom)
      Text("Complete a series of missions to dismiss \(Text("Multiple Misson").bold())")
        .font(.awPremiumFeatures)
        .foregroundColor(.awTabBarItemColor)
        .multilineTextAlignment(.center)
      Spacer()
    }
  }
}
