//
//  View+DismissButton.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension View {

    func setDEDismissButton(
        _ animated: Bool = true,
        dismissHandler: (() -> Void)? = nil
    ) -> some View {
        self
            .navigationBarItems(
                trailing: dismissBarButton(animated: animated, dismissHandler: dismissHandler)
            )
    }

    private func dismissBarButton(animated: Bool = true, dismissHandler: (() -> Void)?) -> some View {
        BarButtonItemView(barItem: .dismiss) {
            dismiss(animated: animated, completion: dismissHandler)
        }
    }

    private func dismiss(animated: Bool, completion: (() -> Void)?) {
        UIApplication.deVisibleViewController()?.dismiss(
            animated: animated,
            completion: completion
        )
    }
}
