//
//  RestaurantRow.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

// MARK: - Constants

extension RestaurantRow {
    enum Constant {
        static let noRatingText = "No ratings"

        enum Size {
            static let cornerRadius: CGFloat = 36
            static let imageHeight: CGFloat = 242
            static let horizontalPadding: CGFloat = Global.Margin.xsmall
            static let verticalPadding: CGFloat = Global.Margin.xsmall
            static let spacing: CGFloat = Global.Margin.tiny
            static let tagSpacing: CGFloat = Global.Margin.tiny
            static let ratingSpacing: CGFloat = 2
            static let starSize: CGFloat = 16
            static let priceTagPadding: CGFloat = Global.Margin.small
            static let cuisineTagPadding: CGFloat = Global.Margin.small
        }

        enum Image {
            static let star = "star.fill"
        }
    }
}

// MARK: - RestaurantRow

struct RestaurantRow: View {
    let restaurant: RestaurantPresentation
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            mainContent
        }
        .buttonStyle(.plain)
    }

    private var mainContent: some View {
        VStack(alignment: .leading, spacing: .zero) {
            restaurantInfoContent
            imageSection
        }
    }
}

// MARK: - View Components

private extension RestaurantRow {

    var restaurantInfoContent: some View {
        VStack(alignment: .leading, spacing: Constant.Size.spacing) {
            restaurantName
            locationAndRating
        }
        .padding(.horizontal, Constant.Size.horizontalPadding)
        .padding(.vertical, Constant.Size.verticalPadding)
    }

    var imageSection: some View {
        ZStack(alignment: .bottomLeading) {
            restaurantImage
            cuisineAndTagContent
        }
    }

    var cuisineAndTagContent: some View {
        VStack(alignment: .leading, spacing: Constant.Size.tagSpacing) {
            priceTag
            cuisineTag
        }
        .padding(.leading, Global.Margin.medium)
        .padding(.bottom, Global.Margin.medium)
    }

    var restaurantImage: some View {
        AsyncImage(url: URL(string: restaurant.imageUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            fallbackImage
        }
        .frame(height: Constant.Size.imageHeight)
        .clipped()
        .cornerRadius(Constant.Size.cornerRadius)
    }

    var fallbackImage: some View {
        Image(.imgRestaurantPlaceholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: Constant.Size.imageHeight)
    }

    var priceTag: some View {
        Text(restaurant.priceLevel.displayText)
            .font(DEFont.semiBold.with(FontSize.smallBody))
            .foregroundColor(Global.theme.tagTextColorV1.color)
            .padding(.horizontal, Constant.Size.priceTagPadding)
            .padding(.vertical, Constant.Size.priceTagPadding / 2)
            .background(Color.white)
            .cornerRadius(20)
    }

    var cuisineTag: some View {
        Text(restaurant.cuisine)
            .font(DEFont.semiBold.with(FontSize.smallBody))
            .foregroundColor(Global.theme.tagTextColorV1.color)
            .padding(.horizontal, Constant.Size.cuisineTagPadding)
            .padding(.vertical, Constant.Size.cuisineTagPadding / 2)
            .background(Color.white)
            .cornerRadius(20)
    }



    var restaurantName: some View {
        Text(restaurant.name)
            .font(DEFont.semiBold.with(FontSize.title2))
            .foregroundColor(Global.theme.primaryTextColor.color)
            .lineLimit(2)
    }

    var locationAndRating: some View {
        HStack {
            locationText
            Spacer()
            ratingSection
        }
    }

    var locationText: some View {
        Text(restaurant.location.address)
            .font(DEFont.semiBold.with(FontSize.smallBody))
            .foregroundColor(Global.theme.primaryTextColorV2.color)
            .lineLimit(1)
    }

    var ratingSection: some View {
        HStack(spacing: Constant.Size.ratingSpacing) {
            if restaurant.rating.hasRating {
                Image(systemName: Constant.Image.star)
                    .font(.system(size: Constant.Size.starSize))
                    .foregroundColor(.yellow)

                Text(restaurant.rating.displayText)
                    .font(DEFont.semiBold.with(FontSize.smallBody))
                    .foregroundColor(Global.theme.tagTextColorV1.color)
            } else {
                Text(Constant.noRatingText)
                    .font(DEFont.semiBold.with(FontSize.smallBody))
                    .foregroundColor(Global.theme.tagTextColorV1.color)
            }
        }
    }


}

// MARK: - Preview

#Preview {
    let sampleRestaurantData = ExploreNetworkController.RestaurantData(
        id: "1",
        type: "restaurant",
        attributes: ExploreNetworkController.RestaurantAttributes(
            name: "Sample Restaurant",
            priceLevel: 2,
            phone: "+1234567890",
            menuUrl: nil,
            cuisine: "Italian",
            imageUrl: "https://example.com/image.jpg",
            latitude: 25.130623,
            longitude: 55.117375,
            addressLine1: "123 Sample Street, Dubai",
            ratingsAverage: "4.5",
            ratingsCount: 123,
            labels: ["Smart Casual", "Good for Dinner", "Accepts Credit Cards"]
        ),
        relationships: ExploreNetworkController.RestaurantRelationships(
            region: ExploreNetworkController.RegionData(
                data: ExploreNetworkController.Region(
                    id: "1",
                    type: "region"
                )
            )
        )
    )
    
    let sampleRestaurant = RestaurantPresentation(from: sampleRestaurantData)
    
    RestaurantRow(restaurant: sampleRestaurant) {
        print("Restaurant tapped")
    }
    .padding()
}
