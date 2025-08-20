//
//  Image+Base64.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI

extension Image {

    init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String),
                let uiImage = UIImage(data: data) else {
            return nil
        }
        self.init(uiImage: uiImage)
    }
}
