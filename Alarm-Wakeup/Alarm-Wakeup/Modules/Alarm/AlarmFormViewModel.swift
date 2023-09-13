//
//  AlarmFormViewModel.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/16/23.
//

import SwiftUI

class AlarmFormViewModel: ObservableObject {
    typealias Dependencies = HasLocalStorageService & HasAlarmService

    @Environment(\.presentationMode) var presentationMode
    var localStorageService: LocalStorageService
    var alarmService: AlarmService
    @Published var isPlaying: Bool
    @Published var isBottomSheetPresenting: Bool = false
    @Published var alaramModel: AlarmModel
    var repeatEveryDay: Bool {
        didSet { alaramModel.repeatEveryDaySet(repeatEveryDay) }
    }

    var ringIn: String {
        return nextUpcomingTime()
    }

    init(isPLaying: Bool = false, alaramModel: AlarmModel = AlarmModel(), dependencies: Dependencies = AppDependencies.shared) {
        self.localStorageService = dependencies.localStorageService
        self.alarmService = dependencies.alarmService
        self.isPlaying = isPLaying
        self.alaramModel = alaramModel
        self.repeatEveryDay = alaramModel.daysToRingCount == Days.maxValue
    }
}

// MARK: Selected Days

extension AlarmFormViewModel {

    func isDaySelected(_ day: Days) -> Bool {
        return alaramModel.isDaySelected(day)
    }

    func dayBtnPressed(_ day: Days) {
        return alaramModel.selectedDaysToggle(day)
    }
}

// MARK: Ring in

extension AlarmFormViewModel {

    private func nextUpcomingTime() -> String {
        if let diffFromAlaramDay = upcomingDateToRingDiff(), let timeToRing = alaramModel.timeToRing.updateDate(by: diffFromAlaramDay), let remaingTimeToRing = Date.getStringFromSecond(timeToRing.getSecondDifferenceFromCurrent) {
            let splitRemaing = remaingTimeToRing.split(separator: " ")
            if splitRemaing[1] == "minutes" && splitRemaing[0] == "0" {
                return "less than 1 min"
            }
            return remaingTimeToRing
        }
        return "few time"
    }

    private func upcomingDateToRingDiff() -> Int? {
        if let currentDay = Days.fromDate(alaramModel.timeToRing) {
            if alaramModel.timeToRing >= Date.now && alaramModel.daysToRing.contains(currentDay) {
                return 0
            } else {
                var dayToAlaram = currentDay.nextOfIt
                while !alaramModel.daysToRing.contains(dayToAlaram) {
                    dayToAlaram = dayToAlaram.nextOfIt
                }
                return currentDay.getDiffinDay(from: dayToAlaram)
            }
        }
        return nil
    }
}

// MARK: Label

extension AlarmFormViewModel {

    var alaramLabel: String {
        return alaramModel.label ?? "none"
    }

    private var isLabelValidated: Bool {
        return alaramModel.isLabelValidated
    }

    func labelSheetBtn() {
        isBottomSheetPresenting.toggle()
    }

    var labelBtnTitle: String {
        return (isLabelValidated ? "Ok" : "Cancel")
    }

    var labelBtnBackgroundColor: Color {
        return (isLabelValidated ? Color.awFloatingButtonColor : Color.awTosterColor)
    }
}

// MARK: Music

extension AlarmFormViewModel {

    var maxVolume: Double {
        return AlarmModel.maxVolume
    }

    func speakerView() -> some View {
        let selectedVolume: Double = alaramModel.selectedVolume

        var image: ImageHelperView
        switch selectedVolume {
        case 0:
            image = ImageHelperView("speaker.fill")
        case selectedVolume where selectedVolume < (maxVolume*0.25):
            image = ImageHelperView("speaker.wave.1.fill")
        case selectedVolume where selectedVolume < (maxVolume*0.70):
            image = ImageHelperView("speaker.wave.2.fill")
        default:
            image = ImageHelperView("speaker.wave.3.fill")
        }
        return image
            .frame(width: 24, height: 24)
    }

    @ViewBuilder
    func playingView() -> some View {
        ImageHelperView(isPlaying ? "pause.fill" : "play.fill")
            .foregroundColor(isPlaying ? nil : Color.awSubTitleForSoundsColor)
    }

    func vibratingView() -> some View {
        ImageHelperView(alaramModel.isVibrating ? "iphone.gen3.radiowaves.left.and.right": "iphone.gen3.slash")
            .frame(width: 24, height: 24)
    }
}

// Submit

extension AlarmFormViewModel {
    func saveAlarm() {
        if alaramModel.isValidate {
            do {
                try localStorageService.addData(alaramModel)
//                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Error while saving data: \(alaramModel) Error: \(error)")
            }
        }
    }
}
