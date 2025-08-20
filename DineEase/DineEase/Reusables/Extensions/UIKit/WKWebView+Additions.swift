//
//  WKWebView+Additions.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import WebKit

extension WKWebView {

    func load(_ urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return
        }

        let request = URLRequest(url: url)
        load(request)
    }
}
