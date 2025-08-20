//
//  DEIconButton.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

struct DEIconButton: View {
    let icon: ImageResource
    let title: String
    let action: () -> Void
    var isEnabled: Bool = true

    var body: some View {
        Button(action: action) {
            HStack(spacing: Global.Margin.small) {
                Image(icon)
                Text(title)
            }
            .applyPrimaryButtonStyling()
        }
        .disabled(!isEnabled)
    }
} 
