//
//  RestaurantDetailScreen.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

// MARK: - Constants

extension RestaurantDetailScreen {
    enum Constant {
        static let navigationTitle = "Restaurant Details"
        
        enum Text {
            static let loadingMessage = "Loading restaurant details..."
            static let errorTitle = "Error loading restaurant details"
            static let retryButtonTitle = "Retry"
            static let emptyStateTitle = "Restaurant Not Found"
            static let emptyStateMessage = "We couldn't find the restaurant details. Please try again later."
        }

        enum Images {
            static let errorIcon = "exclamationmark.triangle"
            static let emptyStateIcon = "fork.knife"
        }
        
        enum Size {
            static let horizontalPadding: CGFloat = Global.Margin.xlarge
            static let verticalPadding: CGFloat = Global.Margin.xlarge
            static let loadingSpacing: CGFloat = Global.Margin.xlarge
            static let iconSize: CGFloat = 50
            static let progressScale: CGFloat = 1.5
        }
    }
}

// MARK: - RestaurantDetailScreen

struct RestaurantDetailScreen: View {
    typealias Restaurant = RestaurantDetailPresentation
    @StateObject private var viewModel: RestaurantDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(restaurantId: String) {
        self._viewModel = StateObject(wrappedValue: RestaurantDetailViewModel(restaurantId: restaurantId))
    }
    
    var body: some View {
        mainContent
            .navigate(
                route: viewModel.route,
                shouldPush: $viewModel.shouldPush,
                shouldPresent: $viewModel.shouldPresent,
                shouldPresentFullscreen: $viewModel.shouldPresentFullscreen
            )
            .navigationBarHidden(true)
            .deToastContainer()
            .onAppear {
                Task {
                    await viewModel.fetchRestaurantDetails()
                }
            }
    }

    private var mainContent: some View {
        VStack(spacing: .zero) {
            if viewModel.isLoading {
                loadingView
            } else if let error = viewModel.error {
                errorView(error: error)
            } else if viewModel.restaurantDetail == nil {
                emptyStateView
            } else {
                restaurantDetailView
            }
        }
        .background(Global.theme.primaryBackgroundColor.color)
    }
}

// MARK: - View Components

private extension RestaurantDetailScreen {

    var loadingView: some View {
        VStack(spacing: Constant.Size.loadingSpacing) {
            ProgressView()
                .scaleEffect(Constant.Size.progressScale)

            Text(Constant.Text.loadingMessage)
                .font(DEFont.medium.with(FontSize.body))
                .foregroundColor(Global.theme.secondaryTextColor.color)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func errorView(error: Error) -> some View {
        VStack(spacing: Constant.Size.loadingSpacing) {
            Image(systemName: Constant.Images.errorIcon)
                .font(.system(size: Constant.Size.iconSize))
                .foregroundColor(Global.theme.errorColor.color)
            
            Text(Constant.Text.errorTitle)
                .font(DEFont.semiBold.with(FontSize.title2))
                .foregroundColor(Global.theme.primaryTextColor.color)
            
            Text(error.localizedDescription)
                .font(DEFont.regular.with(FontSize.body))
                .foregroundColor(Global.theme.secondaryTextColor.color)
                .multilineTextAlignment(.center)
            
            Button(Constant.Text.retryButtonTitle) {
                Task {
                    await viewModel.fetchRestaurantDetails()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(Constant.Size.horizontalPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var emptyStateView: some View {
        ContentUnavailableView(
            Constant.Text.emptyStateTitle,
            systemImage: Constant.Images.emptyStateIcon,
            description: Text(Constant.Text.emptyStateMessage)
        )
    }

    var restaurantDetailView: some View {
        VStack(alignment: .leading, spacing: .zero) {
            if let restaurant = viewModel.restaurantDetail {
                restaurantImageView(restaurant)
                scrollableContent
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }

    // Scrollable content with overlay
    @ViewBuilder
    private var scrollableContent: some View {
        if let restaurant = viewModel.restaurantDetail {
            VStack(spacing: .zero) {
                ScrollView {
                    VStack(alignment: .leading, spacing: Constant.Size.verticalPadding) {
                        overlayContentView(restaurant)
                        restaurantInfoView(restaurant)
                        otherVenuesWithCuisineSection(restaurant)
                        otherVenuesInLocationSection(restaurant)
                    }
                    .padding(.top, Global.Margin.xlarge)
                    .padding(.leading, Constant.Size.horizontalPadding)
                }
                .background(Color.clear)
                .cornerRadius(Global.CornerRadius.extraHigh, corners: [.topLeft, .topRight])
            }
            .background(
                Color.white.cornerRadius(Global.CornerRadius.extraHigh, corners: [.topLeft, .topRight])
            )
            .padding(.top, -40) // Account for overlay offset
        }
    }

    func restaurantImageView(_ restaurant: Restaurant) -> some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: URL(string: restaurant.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(.imgPlaceholderHeader)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 240)
            .clipped()
            
            // Back button
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: Global.Margin.xsmall) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .medium))
                            Text("Back")
                                .font(DEFont.semiBold.with(FontSize.body))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                    }
                    
                    Spacer()
                }
                .padding(.top, 50) // Account for status bar
                .padding(.horizontal, Global.Margin.medium)
                
                Spacer()
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 240)
    }
    
    func overlayContentView(_ restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: Global.Margin.small) {
            HStack(alignment: .center, spacing: Global.Margin.xsmall) {
                Text(restaurant.name)
                    .font(DEFont.semiBold.with(FontSize.title1))
                    .foregroundColor(Global.theme.primaryTextColor.color)

                if restaurant.rating.hasRating {
                    HStack(spacing: Global.Margin.tiny) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 16))
                                            Text(restaurant.rating.displayText)
                        .font(DEFont.semiBold.with(FontSize.body))
                        .foregroundColor(Global.theme.primaryTextColor.color)
                    }
                }
                Spacer()
            }

            if let description = restaurant.description {
                Text(description)
                    .font(DEFont.medium.with(FontSize.smallBody))
                    .foregroundColor(Global.theme.primaryTextColorV3.color)
                    .truncationMode(.tail)
                    .lineLimit(2)
            }

            // Price and Cuisine tags
            HStack(spacing: Global.Margin.small) {
                priceLevelTag(for: restaurant)
                cuisineTag(for: restaurant)
            }
            .font(DEFont.medium.with(FontSize.smallBody))
            .foregroundColor(Global.theme.primaryTextColorV3.color)
            .padding(.top, Global.Margin.tiny)
        }
        .padding(.trailing, Global.Margin.medium)
    }

    @ViewBuilder
    private func priceLevelTag(for restaurant: Restaurant) -> some View {
        HStack(spacing: Global.Margin.tiny) {
            Image(.icDollar)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
            Text(restaurant.priceLevel.displayText)
        }
        .padding(.horizontal, 12)
        .frame(height: 46)
        .background(DEGradient.price)
        .cornerRadius(30) // Capsule style
    }

    @ViewBuilder
    private func cuisineTag(for restaurant: Restaurant) -> some View {
        HStack(spacing: Global.Margin.tiny) {
            Image(.icForkWithKnife)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text(restaurant.cuisine)
        }
        .padding(.horizontal, 12)
        .frame(height: 46)
        .background(DEGradient.cuisine)
        .cornerRadius(30) // Capsule style
    }

    func restaurantInfoView(_ restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: Global.Margin.medium) {
            // Location
            locationSection(restaurant)
            
            // Menu
            if let menuUrl = restaurant.menuUrl {
                menuSection(menuUrl)
            }
            
            // Restaurant Notes
            if let description = restaurant.description {
                restaurantNotesSection(description)
            }
            
            // Labels (without "Amenities" label)
            if !restaurant.labels.isEmpty {
                labelsSection(restaurant.labels)
            }
        }
        .padding(.trailing, Constant.Size.horizontalPadding)
    }

    func locationSection(_ restaurant: Restaurant) -> some View {
        InfoActionCard(
            icon: Image(.icPinLocation),
            title: viewModel.fullAddress(restaurant),
            description: "See venue's address in google maps"
        ) {
            viewModel.openLocationInMaps(restaurant)
        }
    }

    func menuSection(_ menuUrl: String) -> some View {
        InfoActionCard(
            icon: Image(.icDocTextFill),
            title: "Restaurant menu",
            description: "See restaurant menu in pdf"
        ) {
            viewModel.openMenuInBrowser(menuUrl)
        }
    }

    func restaurantNotesSection(_ description: String) -> some View {
        VStack(alignment: .leading, spacing: Global.Margin.small) {
            Text("Notes from the restaurant")
                .font(DEFont.semiBold.with(FontSize.body))
                .foregroundColor(Global.theme.primaryTextColor.color)

            Text(description)
                .font(DEFont.medium.with(FontSize.smallBody))
                .foregroundColor(Global.theme.primaryTextColorV2.color)
        }
        .padding(.vertical, Global.Margin.small)
        .padding(.horizontal, Global.Margin.medium)
        .background(DEGradient.notes)
        .cornerRadius(Global.CornerRadius.mediumHigh)
        .padding(.vertical, Global.Margin.medium)
    }

    func labelsSection(_ labels: [String]) -> some View {
        FlowLayout(spacing: Global.Margin.xsmall) {
            ForEach(labels, id: \.self) { label in
                TagView(text: label)
            }
        }
    }

    func otherVenuesWithCuisineSection(_ restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: Global.Margin.medium) {
            Text("Other venues with \(restaurant.cuisine)")
                .font(DEFont.semiBold.with(FontSize.body))
                .foregroundColor(Global.theme.primaryTextColor.color)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Global.Margin.medium) {
                    ForEach(viewModel.mockPromotionalGroups, id: \.id) { promotionalGroup in
                        RestaurantCard(
                            promotionalGroup: promotionalGroup,
                            currentRestaurantCuisine: restaurant.cuisine,
                            currentRestaurantPriceLevel: restaurant.priceLevel.level,
                            cardWidth: (UIScreen.main.bounds.width - 48) / 2.3
                        )
                    }
                }
            }
        }
    }

    func otherVenuesInLocationSection(_ restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: Global.Margin.medium) {
            Text("Other venues in \(restaurant.location.neighborhoodName ?? "this area")")
                .font(DEFont.semiBold.with(FontSize.body))
                .foregroundColor(Global.theme.primaryTextColor.color)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Global.Margin.medium) {
                    ForEach(viewModel.promotionalGroups, id: \.id) { promotionalGroup in
                        RestaurantCard(
                            promotionalGroup: promotionalGroup,
                            currentRestaurantCuisine: restaurant.cuisine,
                            currentRestaurantPriceLevel: restaurant.priceLevel.level,
                            cardWidth: (UIScreen.main.bounds.width - 48) / 2.3
                        )
                    }
                }
            }
        }
    }


}

// MARK: - Preview

#Preview {
    NavigationView {
        RestaurantDetailScreen(restaurantId: "sample-id")
    }
}
