//
//  RestaurantDetailRouter.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

enum RestaurantDetailRouter: SwiftUIRouting {
    case back
    
    func destination() -> AnyView? {
        switch self {
        case .back:
            return nil // Will be handled by navigation back
        }
    }
}
