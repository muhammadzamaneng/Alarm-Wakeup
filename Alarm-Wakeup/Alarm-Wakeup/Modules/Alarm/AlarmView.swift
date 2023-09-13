//
//  HomeView.swift
//  Alarm-Wakeup
//
//  Created by Dev on 06/02/2023.
//

import SwiftUI

struct AlarmView: View {
    @Environment(\.scenePhase) var scenePhase

    @StateObject var viewModel: AlarmViewModel
    @State var isPresting: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(viewModel.alarms.enumerated()), id: \.offset) { index, alarm in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            ImageHelperView(ASR.clockIconFill)
                            Text(viewModel.getDaysToRing(alarm))
                        }
                        HStack {
                            Text(alarm.timeToRing.timeIn12Hour)
                                .font(.awListAlarmItemTimeFont)
                            Spacer()
                            Toggle("", isOn: viewModel.getAlarmActiveBinding(index, alarm))
                                .frame(width: 10, height: 20)
                                .contentShape(Rectangle())
                                .toggleStyle(.switch)
                                .labelsHidden()
                        }
                        Divider()
                        HStack {
                            Text(viewModel.getAlarmMission(alarm))
                            Spacer()
                            Menu {
                                Button("\(alarm.id)", action: {})
                                Button("Adjust Order", action: {})
                                Button("Cancel", action: {})
                            } label: {
                                ImageHelperView("ellipsis")
                                    .tint(Color.awSubTitleForSoundsColor)
                            }
                        }
                    }
                    .font(.awListAlarmItemFont)
                    .tint(alarm.isActive ? Color.awSelectedItemColor : Color.awSubTitleForSoundsColor)
                    .foregroundColor(alarm.isActive ? Color.awLabelColor : Color.awSubTitleForSoundsColor)
                    .padding()
                }
            }
        }
        .onDisappear(perform: viewWillDisapper)
        .sheet(isPresented: $viewModel.permissionDialog, content: {
            VStack(alignment: .center, spacing: 20) {
                ZStack(alignment: .topTrailing) {
                    GifImage("alarmNotification")
                        .frame(width: 200, height: 200)
                        .frame(maxWidth: .infinity)
                    Toggle(isOn: $viewModel.permissionDialog) {
                        ImageHelperView("xmark")
                            .font(.awTitle2BoldFont)
                    }
                    .toggleStyle(.button)
                    .buttonStyle(.plain)
                    .padding()
                    .tint(Color.awSubTitleForSoundsColor)
                }
                Text("Notification permissions")
                    .font(.awTitle2BoldFont)
                Text("If you want the alarm feature in app please\nallow the following permissions")
                    .multilineTextAlignment(.center)
                    .font(.awDescriptionFont)
                    .foregroundColor(.awSubTitleForSoundsColor)
                Button(action: viewModel.permissionConfirm) {
                    Text("Confirm")
                        .font(.awListTitleFont)
                        .padding(.horizontal, 20)
                }
                .tint(.awNotificationPerBtnColor)
                .controlSize(.large)
                .clipShape(Capsule())
                .buttonStyle(.borderedProminent)
            }
            .presentationDetents([.fraction(0.5), .medium])
            .presentationDragIndicator(.hidden)
        })
        .onChange(of: scenePhase, perform: { newValue in
            if newValue == .active {
                viewModel.checkPermission()
            }
        })
        .floatingView(
            body: floatingButton
        )
        .navigationTitle("Next alaram")
    }

    var floatingButton: some View {
        HStack {
            if viewModel.requiredPermission {
                HStack {
                    Text("Notification permission required in order to set alarm")
                        .foregroundColor(Color.white)
                    Toggle(isOn: $viewModel.permissionDialog) {
                        Text("Allow")
                            .foregroundColor(Color.green)
                            .fontWeight(.bold)
                    }
                    .toggleStyle(.button)
                    .buttonStyle(.plain)
                }
                .fontWeight(.medium)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(Color.awNotificationPerBtnColor)
                .cornerRadius(25, corners: [.topRight, .bottomRight])
                .transition(.move(edge: .leading))
                .padding(.vertical, 10)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 20) {
                if isPresting {
                    floatinngButtonMenu
                }
                Button {
                    withAnimation {
                        isPresting.toggle()
                    }
                } label: {
                    ImageHelperView("plus")
                        .fontWeight(.bold)
                        .circleBackground(fillColor: .awFloatingButtonColor)
                }
            }
            .padding()
            .frame(alignment: .trailing)
        }
    }

    var floatinngButtonMenu: some View {
        VStack(alignment: .trailing, spacing: 10) {
            Button(action: {}) {
                HStack {
                    Text("Quick alarm")
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .foregroundColor(Color(uiColor: .label))
                        .background(Color.awSwitchBackground)
                        .cornerRadius(5)
                    ImageHelperView("alarm")
                        .circleBackground(size: 35)
                }
            }
            NavigationLink(destination: { viewModel.createAlarmView() }) {
                HStack {
                    Text("Alarm")
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .foregroundColor(Color(uiColor: .label))
                        .background(Color.awSwitchBackground)
                        .cornerRadius(5)
                    ImageHelperView(ASR.clockIconFill)
                        .circleBackground(size: 35)
                }
            }
        }
        .padding(.trailing, 8)
        .transition(.move(edge: .trailing))
    }

    func viewWillDisapper() {
        isPresting = false
    }
}

struct HomeView_Previews: PreviewProvider {
    static var viewModel = AlarmViewModel(alarms: AlarmModel.sampleData)
    static var previews: some View {
        AlarmView(viewModel: viewModel)
    }
}
