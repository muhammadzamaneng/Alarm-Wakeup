# Alarm Wakeup
Introducing Alarm Wakeup: Wake up feeling refreshed and energised with Rise & Rest - the ultimate sleep cycle companion. Our app offers a suite of features designed to transform your mornings and improve your sleep quality.

## Features
- **🌅 Custom Alarms:** Set personalised alarms that match your sleep cycle, from a gentle wake-up to a vibrant start to the day..

- **🎵 Choose Your Tune:** Customize your alarm sound with soft to loud ringtones, or select your favorite music to start your day on the right note.

- **🌿 Soothing Sleep Sounds:** Drift off to dreamland with our library of high-quality sleep sounds, sourced directly from YouTube. Explore six different categories, including Nature, White Noise, Meditation, ASMR, and more, to create the perfect ambiance for your slumber.

Why Rise & Rest?

😴 Improve Sleep Quality: Our smart alarm clock uses advanced algorithms to wake you up at the optimal time in your sleep cycle, ensuring you wake up refreshed and ready to tackle the day.

🎶 Soundscapes for Serenity: Experience tranquility with our vast selection of soothing sleep sounds. Whether you need to relax, focus, or sleep better, we've got you covered.

🕰️ Easy to Use: Our intuitive interface makes it effortless to set alarms and select your preferred wake-up tunes. Customize your mornings with just a few taps.

Say goodbye to groggy mornings and hello to a well-rested you. Download Rise & Rest today and start your journey to better sleep and brighter mornings!

## Requirements
iOS 16.0+
Xcode 14.2+
Swift 5.4+

## Installation

Clone or download the repository.
Open the Alarm-Wakeup.xcodeproj file in Xcode.
Build and run the app on a simulator or a physical device.

## Usage
Discover daily motivation with our app! Start your day right by exploring our inspiring feed filled with quotes that uplift your spirit. Choose the categories that speak to you, customizing your daily inspiration. Personalize your experience further by selecting from a range of engaging themes. And don't forget to set daily reminders to stay inspired and on track. Let us be your source of daily motivation!

## Architecture

The app is built using the Model-View-ViewModel Coordinator (MVVM-C) architecture pattern. Here's a brief overview of the different layers:

## Coordinator
The coordinator layer is use to manage the Navigation, State of body. The coordinator in this app `DashboardCoordinator` 

## Model

The data layer that represents the app's data and business logic. In this app, the models are the Category, Sound, Alarm with the type of DayModel and TimerModel.
## View

The UI layer that displays the data to the user and handles user input. In this app, the views are implemented using SwiftUI.
ViewModel: The glue layer that connects the view and the model. The view model handles the business logic and provides the data to the view.
