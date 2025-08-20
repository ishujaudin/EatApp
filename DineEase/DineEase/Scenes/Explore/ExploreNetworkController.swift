//
//  ExploreNetworkController.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Foundation

class ExploreNetworkController {

    func fetchRestaurants(page: Int = 1, limit: Int = 30) async throws -> RestaurantsResponse {
        try await NetworkManager.shared.request(
            endpoint: .fetchRestaurants(page: page, limit: limit),
            responseModel: RestaurantsResponse.self
        )
    }


}

// MARK: - Response Models

extension ExploreNetworkController {

    // MARK: - Restaurants List Response
    struct RestaurantsResponse: Codable {
        let data: [RestaurantData]
        let meta: Meta
        let links: Links
    }

    struct RestaurantData: Codable, Identifiable {
        let id: String
        let type: String
        let attributes: RestaurantAttributes
        let relationships: RestaurantRelationships
    }

    struct RestaurantAttributes: Codable {
        let name: String
        let priceLevel: Int
        let phone: String?
        let menuUrl: String?
        let cuisine: String
        let imageUrl: String
        let latitude: Double
        let longitude: Double
        let addressLine1: String
        let ratingsAverage: String?
        let ratingsCount: Int?
        let labels: [String]

        enum CodingKeys: String, CodingKey {
            case name, phone, cuisine, latitude, longitude, labels
            case priceLevel = "price_level"
            case menuUrl = "menu_url"
            case imageUrl = "image_url"
            case addressLine1 = "address_line_1"
            case ratingsAverage = "ratings_average"
            case ratingsCount = "ratings_count"
        }
    }

    struct RestaurantRelationships: Codable {
        let region: RegionData
    }

    struct RegionData: Codable {
        let data: Region
    }

    struct Region: Codable {
        let id: String
        let type: String
    }

    struct Meta: Codable {
        let limit: Int
        let totalPages: Int
        let totalCount: Int
        let currentPage: Int
        
        enum CodingKeys: String, CodingKey {
            case limit
            case totalPages = "total_pages"
            case totalCount = "total_count"
            case currentPage = "current_page"
        }
    }

    struct Links: Codable {
        let first: String
        let next: String?
        let prev: String?
        let last: String
    }


}
