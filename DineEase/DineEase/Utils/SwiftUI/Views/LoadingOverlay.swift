//
//  LoadingOverlay.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

struct LoadingOverlay: View {
    
    enum State {
        case loaded
        case loading
    }

    @Binding var state: State

    var body: some View {
        ZStack {
            Color.white.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
        }
    }
}
