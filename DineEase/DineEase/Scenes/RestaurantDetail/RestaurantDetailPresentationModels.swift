//
//  RestaurantDetailPresentationModels.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Foundation

// MARK: - Restaurant Detail Presentation Models

struct RestaurantDetailResponsePresentation {
    let restaurant: RestaurantDetailPresentation
    let promotionalGroups: [PromotionalGroupPresentation]
    
    init(from response: RestaurantDetailNetworkController.RestaurantDetailResponse) {
        self.restaurant = RestaurantDetailPresentation(from: response.data)
        self.promotionalGroups = response.included
            .filter { $0.type == "promotional_group" }
            .map { PromotionalGroupPresentation(from: $0) }
    }
}

struct RestaurantDetailPresentation: Identifiable {
    let id: String
    let name: String
    let priceLevel: PriceLevelPresentation
    let phone: String?
    let menuUrl: String?
    let requireBookingPreferenceEnabled: Bool
    let difficult: Bool
    let cuisine: String
    let imageUrl: String
    let location: RestaurantDetailLocationPresentation
    let rating: RestaurantDetailRatingPresentation
    let labels: [String]
    let amenities: AmenitiesPresentation
    let description: String?
    let operatingHours: String?
    let notice: String?
    
    init(from restaurant: RestaurantDetailNetworkController.RestaurantDetailData) {
        self.id = restaurant.id
        self.name = restaurant.attributes.name
        self.priceLevel = PriceLevelPresentation(from: restaurant.attributes.priceLevel)
        self.phone = restaurant.attributes.phone
        self.menuUrl = restaurant.attributes.menuUrl
        self.requireBookingPreferenceEnabled = restaurant.attributes.requireBookingPreferenceEnabled
        self.difficult = restaurant.attributes.difficult
        self.cuisine = restaurant.attributes.cuisine
        self.imageUrl = restaurant.attributes.imageUrl
        self.location = RestaurantDetailLocationPresentation(
            latitude: restaurant.attributes.latitude,
            longitude: restaurant.attributes.longitude,
            address: restaurant.attributes.addressLine1,
            addressLine2: restaurant.attributes.addressLine2,
            city: restaurant.attributes.city,
            province: restaurant.attributes.province,
            postalCode: restaurant.attributes.postalCode,
            neighborhoodName: restaurant.attributes.neighborhoodName
        )
        self.rating = RestaurantDetailRatingPresentation(
            average: restaurant.attributes.ratingsAverage,
            count: restaurant.attributes.ratingsCount,
            imageUrl: restaurant.attributes.ratingsImg
        )
        self.labels = restaurant.attributes.labels
        self.amenities = AmenitiesPresentation(
            alcohol: restaurant.attributes.alcohol,
            smoking: restaurant.attributes.smoking,
            valet: restaurant.attributes.valet,
            outdoorSeating: restaurant.attributes.outdoorSeating
        )
        self.description = restaurant.attributes.description
        self.operatingHours = restaurant.attributes.operatingHours
        self.notice = restaurant.attributes.notice
    }
}

struct RestaurantDetailLocationPresentation {
    let latitude: Double
    let longitude: Double
    let address: String
    let addressLine2: String?
    let city: String?
    let province: String?
    let postalCode: String?
    let neighborhoodName: String?
    
    var coordinate: (lat: Double, lng: Double) {
        return (latitude, longitude)
    }
    
    var fullAddress: String {
        var components: [String] = []
        
        if !address.isEmpty {
            components.append(address)
        }
        
        if let addressLine2 = addressLine2, !addressLine2.isEmpty {
            components.append(addressLine2)
        }
        
        if let city = city, !city.isEmpty {
            components.append(city)
        }
        
        if let province = province, !province.isEmpty {
            components.append(province)
        }
        
        if let postalCode = postalCode, !postalCode.isEmpty {
            components.append(postalCode)
        }
        
        return components.joined(separator: ", ")
    }
    
    var displayAddress: String {
        if let neighborhood = neighborhoodName, !neighborhood.isEmpty {
            return "\(address), \(neighborhood)"
        }
        return address
    }
}

struct RestaurantDetailRatingPresentation {
    let average: String?
    let count: Int?
    let imageUrl: String?
    
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
    
    var ratingImage: String? {
        return imageUrl
    }
}

struct AmenitiesPresentation {
    let alcohol: Bool?
    let smoking: Bool?
    let valet: Bool?
    let outdoorSeating: Bool?
    
    var hasAmenities: Bool {
        return alcohol != nil || smoking != nil || valet != nil || outdoorSeating != nil
    }
    
    var amenitiesList: [String] {
        var amenities: [String] = []
        
        if alcohol == true {
            amenities.append("Alcohol Served")
        }
        
        if smoking == true {
            amenities.append("Smoking Allowed")
        }
        
        if valet == true {
            amenities.append("Valet Parking")
        }
        
        if outdoorSeating == true {
            amenities.append("Outdoor Seating")
        }
        
        return amenities
    }
}

struct PromotionalGroupPresentation: Identifiable {
    let id: String
    let name: String?
    let description: String?
    let imageUrl: String?
    let average: String?
    let total: Int?
    let reviews: [ReviewPresentation]?
    
    init(from included: RestaurantDetailNetworkController.IncludedData) {
        self.id = included.id
        self.name = included.attributes.name
        self.description = included.attributes.description
        self.imageUrl = included.attributes.imageUrl
        self.average = included.attributes.average
        self.total = included.attributes.total
        self.reviews = included.attributes.reviews?.map { ReviewPresentation(from: $0) }
    }
}

struct ReviewPresentation {
    let publishedDate: String
    let rating: Int
    let ratingImageUrl: String
    let url: String
    let text: String
    let user: ReviewUserPresentation
    let title: String
    
    init(from review: RestaurantDetailNetworkController.Review) {
        self.publishedDate = review.publishedDate
        self.rating = review.rating
        self.ratingImageUrl = review.ratingImageUrl
        self.url = review.url
        self.text = review.text
        self.user = ReviewUserPresentation(from: review.user)
        self.title = review.title
    }
}

struct ReviewUserPresentation {
    let username: String
    let location: String?
    
    init(from user: RestaurantDetailNetworkController.ReviewUser) {
        self.username = user.username
        self.location = user.userLocation.name
    }
}

// Reuse the same PriceLevelPresentation from Explore

