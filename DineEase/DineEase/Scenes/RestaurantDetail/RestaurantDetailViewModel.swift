//
//  RestaurantDetailViewModel.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

@MainActor
final class RestaurantDetailViewModel: ObservableObject {
    typealias Router = RestaurantDetailRouter

    // Routing
    @Published var shouldPush = false
    @Published var shouldPresent = false
    @Published var shouldPresentFullscreen = false
    @Published private(set) var route: Router?

    // Networking
    private let networkController: RestaurantDetailNetworkController

    // Published Properties
    @Published var isLoading = false
    @Published var error: Error?
    @Published var restaurantDetail: RestaurantDetailPresentation?
    @Published var promotionalGroups: [PromotionalGroupPresentation] = []
    @Published var mockPromotionalGroups: [PromotionalGroupPresentation] = []

    // Restaurant ID
    private let restaurantId: String

    init(restaurantId: String, networkController: RestaurantDetailNetworkController = RestaurantDetailNetworkController()) {
        self.restaurantId = restaurantId
        self.networkController = networkController
    }
}

// MARK: - Actions

extension RestaurantDetailViewModel {

    func fetchRestaurantDetails() async {
        isLoading = true
        error = nil
        
        do {
            let response = try await networkController.fetchRestaurantDetails(id: restaurantId)
            let presentation = RestaurantDetailResponsePresentation(from: response)
            restaurantDetail = presentation.restaurant
            promotionalGroups = presentation.promotionalGroups
            
            // Always load mock data for cuisine section
            mockPromotionalGroups = loadMockPromotionalGroups()
            
            // If no promotional groups found for location section, use mock data as fallback
            if promotionalGroups.isEmpty {
                promotionalGroups = mockPromotionalGroups
            }
            
        } catch let apiError as NetworkError {
            error = apiError
            DEToastManager.shared.showMessage(apiError.localizedDescription, type: .error)
        } catch {
            self.error = error
            DEToastManager.shared.showMessage("Failed to load restaurant details", type: .error)
        }
        
        isLoading = false
    }
    
    private func loadMockPromotionalGroups() -> [PromotionalGroupPresentation] {
        guard let url = Bundle.main.url(forResource: "MockPromotionalGroups", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let mockGroups = try? JSONDecoder().decode([RestaurantDetailNetworkController.IncludedData].self, from: data) else {
            return []
        }
        return mockGroups.map { PromotionalGroupPresentation(from: $0) }
    }
    
    // MARK: - Helper Functions
    
    func fullAddress(_ restaurant: RestaurantDetailPresentation) -> String {
        return restaurant.location.fullAddress
    }
    

    
    // MARK: - Actions
    
    func openLocationInMaps(_ restaurant: RestaurantDetailPresentation) {
        let address = fullAddress(restaurant)
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        let mapsURL = "https://maps.google.com/?q=\(encodedAddress)"
        
        if let url = URL(string: mapsURL) {
            UIApplication.shared.open(url)
        }
    }
    
    func openMenuInBrowser(_ menuUrl: String) {
        if let url = URL(string: menuUrl) {
            UIApplication.shared.open(url)
        }
    }
}
