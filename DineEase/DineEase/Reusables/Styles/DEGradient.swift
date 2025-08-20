//
//  DEGradient.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

enum DEGradient {
    
    // MARK: - Price Gradient
    // Using colors: #258FAC and #0092AC
    static let price = LinearGradient(
        colors: [
            Color(hex: "#258FAC").opacity(0.1),
            Color(hex: "#0092AC").opacity(0.1)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // MARK: - Cuisine Gradient
    // Using colors: #25ACA8 and #00ACA1
    static let cuisine = LinearGradient(
        colors: [
            Color(hex: "#9DAC25").opacity(0.1),
            Color(hex: "#ACA900").opacity(0.1)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Notes Gradient
    // Using colors: #9DAC25 and #ACA900
    static let notes = LinearGradient(
        colors: [
            Color(hex: "#25ACA8").opacity(0.1),
            Color(hex: "#00ACA1").opacity(0.1)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}


