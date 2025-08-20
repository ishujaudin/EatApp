//
//  View+BackButton.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension View {

    func setDEBackButtonHidden(_ isHidden: Bool, shouldGoBacktoHome: Bool = false) -> some View {
        modifier(DEBackButtonHiddenModifier(view: eraseToAnyView(),
                                             isHidden: isHidden,
                                             shouldGoBacktoHome: shouldGoBacktoHome))
    }
}

private struct DEBackButtonHiddenModifier: ViewModifier {

    let view: AnyView
    let isHidden: Bool
    let shouldGoBacktoHome: Bool

    @Environment(\.presentationMode) var presentationMode

    private var backBarButton: some View {
        BarButtonItemView(barItem: .back) {
            if shouldGoBacktoHome {
                // TODO: go to home
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    func body(content: Content) -> some View {
        if isHidden {
            view
                .navigationBarBackButtonHidden(true)
                .deNavigationBarLeadingItems(
                    BarButtonItemView(barItem: .none)
                        .eraseToAnyView()
                )
        } else {
            view
                .navigationBarBackButtonHidden(true)
                .deNavigationBarLeadingItems(backBarButton.eraseToAnyView())
        }
    }
}
