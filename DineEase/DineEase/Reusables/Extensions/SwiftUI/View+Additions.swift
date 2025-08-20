//
//  View+Additions.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Combine
import SwiftUI

extension View {

    @ViewBuilder
    func wrappedInScrollView(when condition: Bool) -> some View {
        if condition {
            ScrollView(showsIndicators: false) {
                self
            }
        } else {
            self
        }
    }

    /// Type erasing modifier for SwiftUI views.
    /// - Returns: Type erased View.
    func eraseToAnyView() -> AnyView { AnyView(self) }
}

// MARK: - Keyboard

extension View {

  var keyboardPublisher: AnyPublisher<Bool, Never> {
    Publishers
      .Merge(
        NotificationCenter
          .default
          .publisher(for: UIResponder.keyboardWillShowNotification)
          .map { _ in true },
        NotificationCenter
          .default
          .publisher(for: UIResponder.keyboardWillHideNotification)
          .map { _ in false })
      .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
