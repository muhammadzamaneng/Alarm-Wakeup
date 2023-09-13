//
//  AlarmForm.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/16/23.
//

import SwiftUI

struct AlarmForm: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AlarmFormViewModel
    static let size = 4000.0

    @State var gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    init(viewModel: AlarmFormViewModel) {
        self.viewModel = viewModel
    }

    fileprivate func navigationListItem(title: String, subTitle: String, isOn: Bool = false, isSelected: Bool = false) -> some View {
        return ListItemWidget {
            Text(title)
                .font(.awListTitleFont)
                .foregroundColor(.awLabelColor)
        } subView: {
            Text(subTitle.capitalizeFirstLetter)
                .foregroundColor(isOn ? Color.awSelectedItemColor : Color.awSubTitleForSoundsColor)
        } trailingView: {
            ImageHelperView("chevron.forward")
                .foregroundStyle(isSelected ? Color.red : Color.awSecondaryColor)
                .font(.title3)
        }
        .padding(.vertical, 5)
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 10) {
                        DatePicker("", selection: $viewModel.alaramModel.timeToRing, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()

                        Toggle(isOn: $viewModel.repeatEveryDay) {
                            Text("Repeat Every day")
                        }
                        .tint(Color.awSelectedItemColor)
                        .toggleStyle(.switch)
                        .font(.awListTitleFont)
                        HStack {
                            ForEach(Days.allCases) { day in
                                Button {
                                    viewModel.dayBtnPressed(day)
                                } label: {
                                    Text(day.firstLetter)
                                        .font(.title)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .background(viewModel.isDaySelected(day) ? Color.awSelectedItemColor : Color.awTosterColor)
                                        .cornerRadius(5)
                                }.buttonStyle(.plain)
                            }
                        }
                        Text("Ring in \(viewModel.ringIn).")
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                            .background(Color.awTosterColor.opacity(0.5))
                            .cornerRadius(5)
                        Divider()
                            .background(Color.awSelectedItemColor)
                    }
                }
                .onTapGesture { return }
                .listRowBackground(Color.clear)

                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Mission")
                                .font(.awListTitleFont)
                            Text("(0/3)")
                                .foregroundColor(Color.awSubTitleForSoundsColor)
                        }
                        HStack(spacing: 0) {
                            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 0) {
                                VStack(spacing: 20) {
                                    ImageHelperView("plus")
                                        .font(.title2)
                                        .foregroundColor(Color(uiColor: .label))
                                    VStack {
                                        Text("Add")
                                        Text("Mission")
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 25)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke()
                                )
                                .foregroundColor(Color.awSubTitleForSoundsColor)
                            }
                        }
                    }
                }

                Section {
                    HStack(spacing: 20) {
                        HStack(spacing: 15) {
                            viewModel.speakerView()
                            Slider(value: $viewModel.alaramModel.selectedVolume, in: (0...viewModel.maxVolume), step: 1)
                                .tint(Color.awSelectedItemColor)
                            viewModel.playingView()
                                .onTapGesture {
                                    viewModel.isPlaying.toggle()
                                }
                        }
                        Divider()
                        Toggle(isOn: $viewModel.alaramModel.isVibrating) {
                            viewModel.vibratingView()
                        }
                        .toggleStyle(CheckboxStyle(selectedColor: Color.awSelectedItemColor))
                        .tint(Color.awSelectedItemColor)
                        .toggleStyle(.switch)
                        .font(.awListTitleFont)
                    }
                    .padding(.vertical, 15)
                    navigationListItem(title: "Sound", subTitle: "Selected Sound", isOn: true)
                }

                Section {
                    navigationListItem(title: "Alarm Power-Up", subTitle: "Off")
                        .background(
                            NavigationLink(destination: {}, label: {
                                EmptyView()
                            }).opacity(0)
                        )
                }

                Section {
                    navigationListItem(title: "Wake Up Check", subTitle: "Off")
                }

                Section {
                    navigationListItem(title: "Snooze", subTitle: "5 minutes", isOn: true)
                }

                Section {
                    Button(action: viewModel.labelSheetBtn) {
                        navigationListItem(title: "Label", subTitle: viewModel.alaramLabel, isOn: false)
                    }
                }

            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.awSwitchBackground)
            .sheet(isPresented: $viewModel.isBottomSheetPresenting) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Label")
                        .font(.title)
                    TextFieldWidget(
                        placeHolder: "Please enter a label",
                        field: $viewModel.alaramModel.label.toUnwrapped(defaultValue: "", setCallback: viewModel.alaramModel.setLabelCallback),
                        isShowClear: true,
                        bottomBorder: true,
                        bottomBorderColor: .awTosterColor,
                        onSubmit: viewModel.labelSheetBtn
                    )
                    Button(viewModel.labelBtnTitle, action: viewModel.labelSheetBtn)
                        .frame(maxWidth: .infinity)
                        .font(.title2.weight(.bold))
                        .padding(.vertical)
                        .foregroundColor(Color.white)
                        .background(viewModel.labelBtnBackgroundColor)
                        .cornerRadius(5)
                }
                .padding(.horizontal)
                .presentationDetents([.fraction(0.23)])
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Save", action: viewModel.saveAlarm)
                    .font(.title2.weight(.bold))
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .background(Color.awFloatingButtonColor)
                    .cornerRadius(5)
                }
            }
            .toolbarBackground(.white, for: .bottomBar)
            .navigationBarTitle("12:00", displayMode: .inline)
        }
    }
}

struct AlarmForm_Previews: PreviewProvider {
    static var viewModel = AlarmFormViewModel()
    static var previews: some View {
        AlarmForm(viewModel: viewModel)
    }
}
