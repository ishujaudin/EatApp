//
//  DEUIViewRepresentable.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

protocol DEUIViewRepresentable: UIViewRepresentable {

    var dynamicHeight: Binding<CGFloat> { get }
}

extension DEUIViewRepresentable {

    var dynamicHeight: Binding<CGFloat> { .constant(.zero) }

    func updateUIView(_ uiView: Self.UIViewType, context: Self.Context) {}
}
