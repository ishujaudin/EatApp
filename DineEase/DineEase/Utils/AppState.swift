//
//  AppState.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    // MARK: - Public Methods
    
    func authenticate() {
        isAuthenticated = true
    }
    
    func logout() {
        isAuthenticated = false
    }
    
    // Example to toggle dark mode
    func toggleDarkMode() {
        isDarkMode.toggle()
    }

    // Example to toggle authentication state
    func toggleAuthentication() {
        isAuthenticated.toggle()
    }
}
