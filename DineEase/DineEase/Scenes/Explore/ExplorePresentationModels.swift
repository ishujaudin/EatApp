//
//  ExplorePresentationModels.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Foundation

// MARK: - Restaurant List Presentation Models

struct RestaurantListPresentation {
    let restaurants: [RestaurantPresentation]
    let pagination: PaginationPresentation
    
    init(from response: ExploreNetworkController.RestaurantsResponse) {
        self.restaurants = response.data.map { RestaurantPresentation(from: $0) }
        self.pagination = PaginationPresentation(from: response.meta)
    }
}

struct RestaurantPresentation: Identifiable {
    let id: String
    let name: String
    let priceLevel: PriceLevelPresentation
    let phone: String?
    let menuUrl: String?
    let cuisine: String
    let imageUrl: String
    let location: LocationPresentation
    let rating: RatingPresentation
    let labels: [String]
    
    init(from restaurant: ExploreNetworkController.RestaurantData) {
        self.id = restaurant.id
        self.name = restaurant.attributes.name
        self.priceLevel = PriceLevelPresentation(from: restaurant.attributes.priceLevel)
        self.phone = restaurant.attributes.phone
        self.menuUrl = restaurant.attributes.menuUrl
        self.cuisine = restaurant.attributes.cuisine
        self.imageUrl = restaurant.attributes.imageUrl
        self.location = LocationPresentation(
            latitude: restaurant.attributes.latitude,
            longitude: restaurant.attributes.longitude,
            address: restaurant.attributes.addressLine1
        )
        self.rating = RatingPresentation(
            average: restaurant.attributes.ratingsAverage,
            count: restaurant.attributes.ratingsCount
        )
        self.labels = restaurant.attributes.labels
    }
}

struct PriceLevelPresentation {
    let level: Int
    let displayText: String
    
    init(from level: Int) {
        self.level = level
        self.displayText = Self.formatPriceLevel(level)
    }
    
    private static func formatPriceLevel(_ level: Int) -> String {
        switch level {
        case 1: return "$"
        case 2: return "$$"
        case 3: return "$$$"
        case 4: return "$$$$"
        default: return "$$"
        }
    }
}

struct LocationPresentation {
    let latitude: Double
    let longitude: Double
    let address: String
    
    var coordinate: (lat: Double, lng: Double) {
        return (latitude, longitude)
    }
}

struct RatingPresentation {
    let average: String?
    let count: Int?
    
    var hasRating: Bool {
        return average != nil && count != nil
    }
    
    var displayText: String {
        return average ?? "No ratings"
    }
    
    var countText: String {
        guard let count = count else { return "" }
        return "(\(count) reviews)"
    }
}

struct PaginationPresentation {
    let currentPage: Int
    let totalPages: Int
    let totalCount: Int
    let limit: Int
    
    var hasMorePages: Bool {
        return currentPage < totalPages
    }
    
    var nextPage: Int {
        return currentPage + 1
    }
    
    init(from meta: ExploreNetworkController.Meta) {
        self.currentPage = meta.currentPage
        self.totalPages = meta.totalPages
        self.totalCount = meta.totalCount
        self.limit = meta.limit
    }
}
