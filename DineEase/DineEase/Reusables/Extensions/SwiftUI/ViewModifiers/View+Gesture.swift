//
//  View+Gesture.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

enum DEGestureType {
    case `default`
    case simultaneous
}

extension View {
    func onTouchDown(_ type: DEGestureType = .default,
                     perform action: @escaping (() -> Void)) -> some View {
        modifier(DEGestureModifier(type: type, action: action))
    }
}

private struct DEGestureModifier: ViewModifier {
    var type: DEGestureType
    var action: (() -> Void)

    func body(content: Content) -> some View {
        switch type {
        case .`default`:
            background(with: content)
                .gesture(tapGesture)
        case .simultaneous:
            background(with: content)
                .simultaneousGesture(tapGesture)
        }
    }

    private var tapGesture: some Gesture {
        TapGesture()
            .onEnded { _ in
                action()
            }
    }

    private func background(with content: Content) -> some View {
        content
            .contentShape(Rectangle())
    }
}
