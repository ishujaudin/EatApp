//
//  ExploreRouter.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

enum ExploreRouter: SwiftUIRouting {
    case restaurantDetail(restaurantId: String)

    func destination() -> AnyView? {
        switch self {
        case .restaurantDetail(let restaurantId):
            return RestaurantDetailScreen(restaurantId: restaurantId)
                .tint(Global.theme.lightTextColor.color)
                .eraseToAnyView()
        }
    }
}
