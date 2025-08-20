//
//  TagView.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

struct TagView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(DEFont.semiBold.with(FontSize.smallBody))
            .lineLimit(1)
            .foregroundColor(Global.theme.primaryTextColorV4.color)
            .padding(.horizontal, Global.Margin.small)
            .frame(height: 44)
            .background(Global.theme.secondaryBackgroundColor.color)
            .cornerRadius(22) // Capsule style
    }
}

#Preview {
    VStack(spacing: 10) {
        TagView(text: "WiFi")
        TagView(text: "Air Conditioning")
        TagView(text: "Outdoor Seating")
    }
    .padding()
}
