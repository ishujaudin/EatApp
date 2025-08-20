//
//  View+RTLSupport.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension View {

    func supportRTL(isArabic: Bool) -> some View {
        modifier(RTLSupportModifier(isArabic: isArabic))
    }
}

private struct RTLSupportModifier: ViewModifier {

    let isArabic: Bool

    func body(content: Content) -> some View {
        content
            .frame(
                maxWidth: .infinity,
                alignment: isArabic ? .trailing : .leading
            )
            .multilineTextAlignment(isArabic ? .trailing : .leading)
    }
}
