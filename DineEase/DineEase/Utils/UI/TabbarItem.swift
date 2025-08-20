//
//  TabbarItem.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Foundation

enum TabbarItem: CaseIterable {
    case home
    case vote
    case history
    case audit
    case profile

    var imageName: String {
        switch self {
        case .home:
            return "ic_tab_home"
        case .vote:
            return "ic_tab_vote"
        case .history:
            return "ic_clock_rotate_ccw"
        case .audit:
            return "ic_tab_audit"
        case .profile:
            return "ic_tab_profile"
        }
    }

    var font: DEFont { .semiBold }
    var fontSize: CGFloat { FontSize.xxSmallFootnote }
    var size: CGSize { CGSize(width: 24, height: 24) }
}
