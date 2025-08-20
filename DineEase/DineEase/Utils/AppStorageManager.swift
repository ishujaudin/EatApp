//
//  AppStorageManager.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

// MARK: - Keys

extension AppStorageManager {
    enum Key {
        static let username = "username"
        static let phone = "phone"
        static let onboardingCompleted = "onboardingCompleted"
        static let lastScannedMRZ = "lastScannedMRZ"
    }
}

// MARK: - AppStorageManager

struct AppStorageManager {
    @AppStorage(Key.username) static var username: String = ""
    @AppStorage(Key.phone) static var phone: String = ""
    @AppStorage(Key.onboardingCompleted) static var onboardingCompleted: Bool = false
    @AppStorage(Key.lastScannedMRZ) static var lastScannedMRZ: String = ""

    static func clearUserData() {
        username = ""
        phone = ""
    }

    static func setOnboardingCompleted() {
        onboardingCompleted = true
    }

    // MARK: - Passport Data Persistence
}
