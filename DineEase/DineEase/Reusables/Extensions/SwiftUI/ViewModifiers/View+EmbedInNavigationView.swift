//
//  View+EmbedInNavigationView.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension View {

    /// Embeds the content in NavigationStack.
    ///
    /// Use this modifier as the last UI related modifier applied to the root view of a screen.
    /// It wraps the content in NavigationStack, enabling navigation features such as navigation bar,
    /// navigation title, navigation links, etc.
    ///
    /// Example:
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         Text("Hello, World!")
    ///             .navigationTitle("Title")
    ///             .navigationBarTitleDisplayMode(.inline)
    ///             .embedInNavigationStack()
    ///     }
    /// }
    /// ```
    ///
    /// - Returns: A view embedded in a NavigationStack.
    func embedInNavigationStack() -> some View {
        modifier(EmbedInNavigationViewModifier())
    }
}

private struct EmbedInNavigationViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        NavigationStack {
            content
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
