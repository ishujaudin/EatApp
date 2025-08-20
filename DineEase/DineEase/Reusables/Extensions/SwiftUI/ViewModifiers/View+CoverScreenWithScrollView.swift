//
//  View+CoverScreenWithScrollView.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension View {

    func coverScreenWithScrollView() -> some View {
        modifier(CoverScreenWithScrollViewViewModifier(view: eraseToAnyView()))
    }
}

private struct CoverScreenWithScrollViewViewModifier: ViewModifier {

    let view: AnyView

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ScrollView {
                view
                    .frame(minHeight: geometry.size.height)
            }
        }
    }
}
