//
//  View+WidthChange.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

private struct ViewWidthKey: PreferenceKey {

    static let defaultValue: CGFloat = 0

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

extension View {

    func notifyWidthChange(_ width: Binding<CGFloat>) -> some View {
        modifier(WidthModifier(width: width))
    }
}

private struct WidthModifier: ViewModifier {

    @Binding var width: CGFloat

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear.preference(key: ViewWidthKey.self,
                                       value: geometry.size.width)
            })
            .onPreferenceChange(ViewWidthKey.self) { value in
                if value > self.width {
                    self.width = value
                }
            }
    }
}
