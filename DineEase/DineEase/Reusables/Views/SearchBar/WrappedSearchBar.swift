//
//  WrappedSearchBar.swift
//  BFS
//
//  Created by Atakan Harani on 25.10.2021.
//  Copyright (c) 2021 Commencis. All rights reserved.
//
//  Save to the extent permitted by law, you may not use, copy, modify,
//  distribute or create derivative works of this material or any part
//  of it without the prior written consent of Commencis.
//  Any reproduction of this material must contain this notice.
//

import SwiftUI
import UIKit

struct WrappedSearchBar: DEUIViewRepresentable {

    private enum Constant {

        static let searchIconImageName = "ic_search_icon"
    }

    @Binding var text: String
    @Binding var dynamicHeight: CGFloat
    var placeholderText = "Search"

    var searchHandler: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<WrappedSearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.textColor = .black
        searchBar.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.setImage(UIImage(named: Constant.searchIconImageName), for: .search, state: .normal)
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: Global.Margin.xsmall, vertical: .zero)

        return searchBar
    }

    func updateUIView(
        _ uiView: UISearchBar, context: UIViewRepresentableContext<WrappedSearchBar>
    ) {
        uiView.text = text
        uiView.placeholder = placeholderText
    }

    class Coordinator: NSObject, UISearchBarDelegate {

        var parent: WrappedSearchBar
        var searchButtonPressed = false
        weak var searchBar: UISearchBar?

        init(parent: WrappedSearchBar) {
            self.parent = parent
            searchButtonPressed = false
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.searchBar = searchBar
            parent.text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.searchBar = searchBar
            searchButtonPressed = true
            searchBar.resignFirstResponder()
            parent.searchHandler?()
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            self.searchBar = searchBar
            guard searchButtonPressed else {
                parent.searchHandler?()
                return
            }
            searchButtonPressed = false
        }

        @objc func languageDidChange() {
            guard let searchBar = searchBar else { return }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
