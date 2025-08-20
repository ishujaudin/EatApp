//
//  ExploreViewModel.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Combine
import SwiftUI

@MainActor
final class ExploreViewModel: ObservableObject {
    typealias Router = ExploreRouter

    // Routing
    @Published var shouldPush = false
    @Published var shouldPresent = false
    @Published var shouldPresentFullscreen = false
    @Published private(set) var route: Router?
    @Published var searchText = ""

    // Networking
    private let networkController: ExploreNetworkController

    // Published Properties
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var error: Error?
    @Published var restaurants: [RestaurantPresentation] = []
    
    // Pagination
    @Published var currentPage = 1
    @Published var totalPages = 1
    @Published var hasMorePages = true

    private var cancellables: Set<AnyCancellable> = []

    init(networkController: ExploreNetworkController = ExploreNetworkController()) {
        self.networkController = networkController
        addSubsriber()
    }
}

// MARK: - Actions

extension ExploreViewModel {

    func fetchRestaurants(searchText: String = "") async {
        isLoading = true
        error = nil
        currentPage = 1
        
        do {
            let response = try await networkController.fetchRestaurants(page: currentPage, search: searchText.isEmpty ? self.searchText : searchText)
            let presentation = RestaurantListPresentation(from: response)
            restaurants = presentation.restaurants
            totalPages = presentation.pagination.totalPages
            hasMorePages = presentation.pagination.hasMorePages
        } catch let apiError as NetworkError {
            error = apiError
            DEToastManager.shared.showMessage(apiError.localizedDescription, type: .error)
        } catch {
            self.error = error
            DEToastManager.shared.showMessage("Failed to load restaurants", type: .error)
        }
        
        isLoading = false
    }
    
    func loadMoreRestaurants() async {
        guard hasMorePages && !isLoadingMore else { return }
        
        isLoadingMore = true
        
        do {
            let nextPage = currentPage + 1
            let response = try await networkController.fetchRestaurants(page: nextPage)
            let presentation = RestaurantListPresentation(from: response)
            restaurants.append(contentsOf: presentation.restaurants)
            currentPage = nextPage
            hasMorePages = presentation.pagination.hasMorePages
        } catch {
            DEToastManager.shared.showMessage("Failed to load more restaurants", type: .error)
        }
        
        isLoadingMore = false
    }

    func didTapRestaurant(_ restaurant: RestaurantPresentation) {
        HapticManager.shared.playLightImpact()
        route = .restaurantDetail(restaurantId: restaurant.id)
        shouldPush = true
    }

    func resetNavigationState() {
        shouldPush = false
        shouldPresent = false
        shouldPresentFullscreen = false
        route = nil
    }
}

// MARK: - Public Methods

extension ExploreViewModel {

    func addSubsriber() {

        cancellables.insert(
            $searchText
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .sink { searchText in
                    guard searchText.isEmpty == false else { return }
                    Task { await self.fetchRestaurants(searchText: searchText) }
                }
        )
    }
}
