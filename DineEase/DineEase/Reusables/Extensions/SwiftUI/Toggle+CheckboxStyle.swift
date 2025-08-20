//
//  Toggle+CheckboxStyle.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension ToggleStyle where Self == ToggleCheckboxStyle {

    static var checklist: ToggleCheckboxStyle { .init() }
}

struct ToggleCheckboxStyle: ToggleStyle {

    private enum Constant {

        static let selectedCheckboxImageName = "ic_navigation_checkBox"
        static let unselectedCheckboxImageName = "ic_unselected_checkBox"
        static let checkboxImageHeight = 24.0
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(DEFont.regular.with(FontSize.body))
                .foregroundColor(Global.theme.primaryTextColor.color)

            Spacer()
            Button(action: {
                configuration.isOn.toggle()
            },
                   label: {
                Image(configuration.isOn ?
                      Constant.selectedCheckboxImageName : Constant.unselectedCheckboxImageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: Constant.checkboxImageHeight)
            })
        }
    }
}
