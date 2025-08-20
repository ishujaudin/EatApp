//
//  RestaurantCard.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

struct RestaurantCard: View {
    let promotionalGroup: PromotionalGroupPresentation
    let currentRestaurantCuisine: String
    let currentRestaurantPriceLevel: Int
    let cardWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: Global.Margin.small) {
            // Restaurant Image
            AsyncImage(url: URL(string: promotionalGroup.imageUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(.imgRestaurantPlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: cardWidth, height: 105)
            .clipped()
            .cornerRadius(Global.CornerRadius.regular)
            
            // Restaurant Name
            Text(promotionalGroup.name ?? "")
                .font(DEFont.semiBold.with(FontSize.body))
                .foregroundColor(Global.theme.primaryTextColor.color)
                .lineLimit(1)
            
            // Cuisine Type (using current restaurant's cuisine)
            HStack(spacing: 4) {
                Image(.icForkWithKnife)
                    .resizable()
                    .frame(width: 12, height: 12)
                Text(currentRestaurantCuisine)
                    .font(DEFont.regular.with(FontSize.smallBody))
                    .foregroundColor(Global.theme.secondaryTextColor.color)
            }
            
            // Price Level (using current restaurant's price level)
            HStack(spacing: 4) {
                Image(.icDollar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                Text(String(repeating: "$", count: currentRestaurantPriceLevel))
                    .font(DEFont.semiBold.with(FontSize.smallBody))
                    .foregroundColor(Global.theme.primaryTextColorV3.color)
            }
        }
        .frame(width: cardWidth)
    }
}
