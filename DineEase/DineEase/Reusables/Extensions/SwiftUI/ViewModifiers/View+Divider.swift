//
//  View+Divider.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension View {

    func deDivider(isHidden: Bool = false,
                    position: DEDividerPosition = .bottom,
                    leadingPadding: CGFloat = .zero,
                    trailingPadding: CGFloat = .zero,
                    opacity: DEDividerOpacity = .high) -> some View {
        modifier(DividerModifier(view: eraseToAnyView(),
                                 isHidden: isHidden,
                                 position: position,
                                 leadingPadding: leadingPadding,
                                 trailingPadding: trailingPadding,
                                 opacity: opacity))
    }
}

enum DEDividerPosition {

    case top
    case bottom
    case both
}

enum DEDividerOpacity: Double {

    case low = 0.2
    case mid = 0.5
    case high = 1.0
}

private struct DividerModifier: ViewModifier {

    let view: AnyView
    let isHidden: Bool
    let position: DEDividerPosition
    let leadingPadding: CGFloat
    let trailingPadding: CGFloat
    let opacity: DEDividerOpacity

    private var divider: some View {
        Divider()
            .background(Global.theme.dividerColor.color)
            .opacity(opacity.rawValue)
            .padding(.leading, leadingPadding)
            .padding(.trailing, trailingPadding)
    }

    func body(content: Content) -> some View {
        // TODO: iOS 13 fix
        if isHidden {
            view
        } else {
            VStack(spacing: .zero) {
                switch position {
                case .top:
                    divider
                    view
                case .bottom:
                    view
                    divider
                case .both:
                    divider
                    view
                    divider
                }
            }
        }
    }
}
