//
//  InfoActionCard.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

struct InfoActionCard: View {
    let icon: Image
    let title: String
    let description: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: Global.Margin.small) {
                content
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var content: some View {
        HStack {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: Global.Margin.tiny) {
                Text(title)
                    .font(DEFont.medium.with(FontSize.body))
                    .foregroundColor(Global.theme.primaryTextColorV3.color)

                Text(description)
                    .font(DEFont.medium.with(FontSize.tinyText))
                    .foregroundColor(Global.theme.secondaryTextColor.color)
            }

            Spacer()

            Image(.icChevronRight)
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
        }
        .padding(.trailing, Global.Margin.medium)
        .padding(.vertical, Global.Margin.tiny)
    }
}

#Preview {
    InfoActionCard(
        icon: Image(.icPinLocation),
        title: "Location",
        description: "See venue's address in google maps"
    ) {
        print("Action tapped")
    }
    .padding()
}
