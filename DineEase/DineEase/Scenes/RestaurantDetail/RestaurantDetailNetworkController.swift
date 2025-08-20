//
//  RestaurantDetailNetworkController.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Foundation

class RestaurantDetailNetworkController {

    func fetchRestaurantDetails(id: String) async throws -> RestaurantDetailResponse {
        try await NetworkManager.shared.request(
            endpoint: .fetchRestaurantDetails(id: id),
            responseModel: RestaurantDetailResponse.self
        )
    }
}

// MARK: - Response Models

extension RestaurantDetailNetworkController {

    // MARK: - Restaurant Detail Response
    struct RestaurantDetailResponse: Codable {
        let data: RestaurantDetailData
        let included: [IncludedData]
    }

    struct IncludedData: Codable {
        let id: String
        let type: String
        let attributes: IncludedAttributes
        let relationships: IncludedRelationships?
        
        enum CodingKeys: String, CodingKey {
            case id, type, attributes, relationships
        }
    }

    struct IncludedAttributes: Codable {
        let firstSeating: Int?
        let lastSeating: Int?
        let startDate: String?
        let endDate: String?
        let shiftType: String?
        let daysOfWeek: [Int]?
        let name: String?
        let description: String?
        let regionId: String?
        let key: String?
        let slug: String?
        let pageTitle: String?
        let pageDescription: String?
        let restaurantsCount: Int?
        let imageUrl: String?
        let average: String?
        let total: Int?
        let reviews: [Review]?
        
        enum CodingKeys: String, CodingKey {
            case firstSeating = "first_seating"
            case lastSeating = "last_seating"
            case startDate = "start_date"
            case endDate = "end_date"
            case shiftType = "shift_type"
            case daysOfWeek = "days_of_week"
            case name, description
            case regionId = "region_id"
            case key, slug
            case pageTitle = "page_title"
            case pageDescription = "page_description"
            case restaurantsCount = "restaurants_count"
            case imageUrl = "image_url"
            case average, total, reviews
        }
    }

    struct IncludedRelationships: Codable {
        // Empty for now, can be extended if needed
    }

    struct Review: Codable {
        let publishedDate: String
        let rating: Int
        let ratingImageUrl: String
        let url: String
        let text: String
        let user: ReviewUser
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case publishedDate = "published_date"
            case rating
            case ratingImageUrl = "rating_image_url"
            case url, text, user, title
        }
    }

    struct ReviewUser: Codable {
        let username: String
        let userLocation: UserLocation
        
        enum CodingKeys: String, CodingKey {
            case username
            case userLocation = "user_location"
        }
    }

    struct UserLocation: Codable {
        let name: String?
        let id: String?
    }

    struct RestaurantDetailData: Codable {
        let id: String
        let type: String
        let attributes: RestaurantDetailAttributes
        let relationships: RestaurantDetailRelationships
    }

    struct RestaurantDetailAttributes: Codable {
        let name: String
        let priceLevel: Int
        let phone: String?
        let menuUrl: String?
        let requireBookingPreferenceEnabled: Bool
        let difficult: Bool
        let cuisine: String
        let imageUrl: String
        let latitude: Double
        let longitude: Double
        let addressLine1: String
        let addressLine2: String?
        let ratingsAverage: String?
        let ratingsCount: Int?
        let labels: [String]
        let alcohol: Bool?
        let deal: String?
        let description: String?
        let establishmentType: String?
        let externalRatingsUrl: String?
        let imageUrls: [String]?
        let neighborhoodName: String?
        let notice: String?
        let operatingHours: String?
        let outdoorSeating: Bool?
        let postalCode: String?
        let province: String?
        let relationshipType: String?
        let reservationNoticeDuration: Int?
        let smoking: Bool?
        let valet: Bool?
        let slug: String?
        let key: String?
        let city: String?
        let customConfirmationComments: String?
        let termsAndConditions: String?
        let ratingsImg: String?

        enum CodingKeys: String, CodingKey {
            case name, phone, cuisine, latitude, longitude, labels, alcohol, deal, description, notice, smoking, valet, slug, key, city
            case priceLevel = "price_level"
            case menuUrl = "menu_url"
            case requireBookingPreferenceEnabled = "require_booking_preference_enabled"
            case difficult
            case imageUrl = "image_url"
            case addressLine1 = "address_line_1"
            case addressLine2 = "address_line_2"
            case ratingsAverage = "ratings_average"
            case ratingsCount = "ratings_count"
            case establishmentType = "establishment_type"
            case externalRatingsUrl = "external_ratings_url"
            case imageUrls = "image_urls"
            case neighborhoodName = "neighborhood_name"
            case operatingHours = "operating_hours"
            case outdoorSeating = "outdoor_seating"
            case postalCode = "postal_code"
            case province
            case relationshipType = "relationship_type"
            case reservationNoticeDuration = "reservation_notice_duration"
            case customConfirmationComments = "custom_confirmation_comments"
            case termsAndConditions = "terms_and_conditions"
            case ratingsImg = "ratings_img"
        }
    }

    struct RestaurantDetailRelationships: Codable {
        let region: RegionData
        let promotionalGroups: PromotionalGroupsData
        let rating: RatingData
        let experiences: ExperiencesData
        let onlineSeatingShifts: OnlineSeatingShiftsData
        
        enum CodingKeys: String, CodingKey {
            case region
            case promotionalGroups = "promotional_groups"
            case rating
            case experiences
            case onlineSeatingShifts = "online_seating_shifts"
        }
    }

    struct RegionData: Codable {
        let data: Region
    }

    struct Region: Codable {
        let id: String
        let type: String
    }

    struct PromotionalGroupsData: Codable {
        let data: [PromotionalGroup]
    }

    struct PromotionalGroup: Codable {
        let id: String
        let type: String
    }

    struct RatingData: Codable {
        let data: Rating?
    }

    struct Rating: Codable {
        let id: String
        let type: String
    }

    struct ExperiencesData: Codable {
        let data: [Experience]
    }

    struct Experience: Codable {
        let id: String
        let type: String
    }

    struct OnlineSeatingShiftsData: Codable {
        let data: [OnlineSeatingShift]
    }

    struct OnlineSeatingShift: Codable {
        let id: String
        let type: String
    }
}
