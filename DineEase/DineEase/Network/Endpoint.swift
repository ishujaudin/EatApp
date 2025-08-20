//
//  Endpoint.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Alamofire

enum Endpoint {
    static let baseURL = "https://api.eat-sandbox.co/consumer/v2"

    case fetchRestaurants(page: Int = 1, limit: Int = 30, search: String = "")
    case fetchRestaurantDetails(id: String)

    var path: String {
        switch self {
        case .fetchRestaurants: return "/restaurants"
        case .fetchRestaurantDetails(let id): return "/restaurants/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchRestaurants, .fetchRestaurantDetails: return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .fetchRestaurants(let page, let limit, let search):
            return [
                "region_id": "3906535a-d96c-47cf-99b0-009fc9e038e0",
                "page": page,
                "limit": limit,
                "q": search
            ]
        case .fetchRestaurantDetails:
            return nil
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .fetchRestaurants, .fetchRestaurantDetails:
            return URLEncoding.default
        }
    }

    var headers: HTTPHeaders {
        return [
            "Accept": "application/json"
        ]
    }
}
