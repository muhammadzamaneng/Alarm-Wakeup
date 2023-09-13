//
//  TextFieldWidget.swift
//  Alarm-Wakeup
//
//  Created by Dev on 3/22/23.
//

import SwiftUI

struct TextFieldWidget: View {
    let sfSymbols: String?
    let placeHolder: String
    @Binding var field: String
    let font: Font
    let onSubmit: () -> Void
    let isShowClear: Bool
    let bottomBorder: Bool
    let bottonBorderHeight: Double
    var bottomBorderColor: Color
    var promotMsg: String

    init(sfSymbols: String? = nil, placeHolder: String, field: Binding<String>, font: Font = .title3, isShowClear: Bool = false, bottomBorder: Bool = false, bottonBorderHeight: Double = 0.33, bottomBorderColor: Color = Color.gray, promotMsg: String = "", onSubmit: @escaping () -> Void = {}) {
        self.sfSymbols = sfSymbols
        self.placeHolder = placeHolder
        self._field = field
        self.font = font
        self.isShowClear = isShowClear
        self.bottomBorder = bottomBorder
        self.bottonBorderHeight = bottonBorderHeight
        self.bottomBorderColor = bottomBorderColor
        self.promotMsg = promotMsg
        self.onSubmit = onSubmit
    }

    var body: some View {
        VStack {
            HStack {
                if let sfSymbols = sfSymbols {
                    ImageHelperView(sfSymbols)
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                TextField("", text: $field)
                    .onSubmit {
                        onSubmit()
                    }
                    .placeholder(when: field.isEmpty, placeholder: {
                        Text(placeHolder).foregroundColor(bottomBorderColor)
                    })
                    .if(isShowClear, transform: { $0.onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }})
            }
            if bottomBorder {
                Divider()
                    .frame(height: bottonBorderHeight)
                    .background(bottomBorderColor)
            }
            Text(promotMsg)
                .font(.caption)
        }
    }
}

struct TextFieldWidget_Previews: PreviewProvider {
    @State static var field: String = ""
    static var previews: some View {
        TextFieldWidget(placeHolder: "Enter", field: $field, bottomBorder: true)
            .padding()
    }
}
