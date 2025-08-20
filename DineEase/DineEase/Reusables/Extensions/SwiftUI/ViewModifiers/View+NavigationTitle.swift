//
//  View+NavigationTitle.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension View {

    func deNavigationTitle(_ text: String) -> some View {
        modifier(NavigationTitleModifier(text: text))
    }
}

struct NavigationTitleModifier: ViewModifier {
    let text: String

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    titleView
                }
            }
    }

    private var titleView: some View {
        Text(text)
            .font(DEFont.semiBold.with(FontSize.body))
            .foregroundColor(Global.theme.navigationBarTextColor.color)
    }
}
