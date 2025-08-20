//
//  DEUIViewControllerRepresentable.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Foundation
import SwiftUI

protocol DEUIViewControllerRepresentable: UIViewControllerRepresentable { }

extension DEUIViewControllerRepresentable {

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeCoordinator() -> () -> Void {
        return {}
    }
}
