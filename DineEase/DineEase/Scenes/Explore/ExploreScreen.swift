//
//  ExploreScreen.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

// MARK: - Constants

extension ExploreScreen {
    enum Constant {
        static let navigationTitle = "Restaurants"

        enum Text {
            static let loadingMessage = "Loading restaurants..."
            static let errorTitle = "Error loading restaurants"
            static let retryButtonTitle = "Retry"
            static let emptyStateTitle = "No Restaurants Found"
            static let emptyStateMessage = "We couldn't find any restaurants at the moment. Please try again later."
        }

        enum Images {
            static let errorIcon = "exclamationmark.triangle"
            static let emptyStateIcon = "fork.knife"
        }

        enum Size {
            static let horizontalPadding: CGFloat = Global.Margin.medium
            static let verticalPadding: CGFloat = Global.Margin.medium
            static let listSpacing: CGFloat = Global.Margin.medium
            static let loadingSpacing: CGFloat = Global.Margin.xlarge
            static let topPadding: CGFloat = Global.Margin.large
            static let iconSize: CGFloat = 50
            static let progressScale: CGFloat = 1.5
        }
    }
}

// MARK: - ExploreScreen

struct ExploreScreen: View {
    @StateObject private var viewModel = ExploreViewModel()
    @State private var searchBarHeight: CGFloat = .zero
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white       // light background
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .clear           // remove separator line
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        mainContent
            .navigate(
                route: viewModel.route,
                shouldPush: $viewModel.shouldPush,
                shouldPresent: $viewModel.shouldPresent,
                shouldPresentFullscreen: $viewModel.shouldPresentFullscreen
            )
            .navigationTitle(Constant.navigationTitle)
            .navigationBarTitleDisplayMode(.large)
            .embedInNavigationStack()
            .deToastContainer()
            .onFirstAppear {
                Task { await viewModel.fetchRestaurants() }
            }
    }

    private var mainContent: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let error = viewModel.error {
                errorView(error: error)
            } else if viewModel.restaurants.isEmpty {
                emptyStateView
            } else {
                restaurantListView
            }
        }
        .background(Global.theme.primaryBackgroundColor.color)
    }
}

// MARK: - View Components

private extension ExploreScreen {

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
                    await viewModel.fetchRestaurants()
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
}

// MARK: - Rsstaurants List

private extension ExploreScreen {

    var searchBar: some View {
        WrappedSearchBar(text: $viewModel.searchText,
                         dynamicHeight: $searchBarHeight, searchHandler: {
            Task { await viewModel.fetchRestaurants() }
            
        })
        .frame(height: searchBarHeight)
        .padding(.top, Global.Margin.large)
        .padding(.horizontal, Global.Margin.medium)
    }

    var restaurantListView: some View {
        VStack(spacing: Global.Margin.medium) {
            searchBar
            ScrollView {
                LazyVStack(spacing: Constant.Size.listSpacing) {
                    ForEach(Array(viewModel.restaurants.enumerated()), id: \.element.id) { index, restaurant in
                        RestaurantRow(restaurant: restaurant) {
                            viewModel.didTapRestaurant(restaurant)
                        }
                        .onAppear {
                            // Load more when we're near the end (last 3 items)
                            if index >= viewModel.restaurants.count - 3 &&
                               viewModel.hasMorePages &&
                               !viewModel.isLoadingMore {
                                Task {
                                    await viewModel.loadMoreRestaurants()
                                }
                            }
                        }
                    }

                    if viewModel.isLoadingMore {
                        paginationLoadingView
                    }
                }
                .padding(.horizontal, Constant.Size.horizontalPadding)
                .padding(.top, Constant.Size.topPadding)
            }
        }
    }

    var paginationLoadingView: some View {
        HStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.2)
            Spacer()
        }
        .padding(.vertical, Global.Margin.medium)
    }
}

// MARK: - Preview

#Preview {
    ExploreScreen()
}
