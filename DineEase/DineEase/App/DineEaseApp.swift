//
//  DineEaseApp.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

@main
struct DineEaseApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(appState)
            }
        }
    }
}
