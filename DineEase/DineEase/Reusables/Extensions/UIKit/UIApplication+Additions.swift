//
//  UIApplication+Additions.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import SwiftUI
import UIKit

// MARK: - Key window

extension UIApplication {

    static var keyWindow: UIWindow {
        UIApplication.shared.windows.first { $0.isKeyWindow } ??
            UIWindow(frame: UIScreen.main.bounds)
    }

    static func currentKeyWindow() -> UIWindow? {
        let connectedScene = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }.first { $0 is UIWindowScene }
        let window = connectedScene.flatMap { $0 as? UIWindowScene }?.windows.first(where: \.isKeyWindow)
        return window
    }

    static var statusBarFrame: CGRect {
        keyWindow.windowScene?.statusBarManager?.statusBarFrame ?? .zero
    }

    static var statusBarHeight: CGFloat {
        statusBarFrame.height
    }

    static func deVisibleViewController(
        inside parentViewController: UIViewController? = keyWindow.rootViewController
    ) -> UIViewController? {
        if let navigationController = parentViewController as? UINavigationController {
            return deVisibleViewController(inside: navigationController.visibleViewController)
        }

        if let tabBarController = parentViewController as? UITabBarController,
           let selected = tabBarController.selectedViewController {
            return deVisibleViewController(inside: selected)
        }

        if let presented = parentViewController?.presentedViewController {
            return deVisibleViewController(inside: presented)
        }

        if (parentViewController as? UIHostingController<AnyView>) != nil {
            if let siblingController = parentViewController?.parent?.children.first(
                where: { controller in
                    return (controller as? UIHostingController<AnyView>) == nil
                }
            ) {
                return deVisibleViewController(inside: siblingController)
            }
        }

        return parentViewController
    }

    /// Presents screen even if a screen is already presented
    /// - Parameter screen: AnyView
    static func forcePresentScreen(_ screen: AnyView) {
        deVisibleViewController()?.present(
            UIHostingController(rootView: screen),
            animated: true,
            completion: nil
        )
    }

    /// Pushes SwiftUI screen on the top visible UIViewController
    /// - Parameter screen: AnyView
    static func push(_ screen: AnyView) {
        deVisibleViewController()?.navigationController?.pushViewController(
            UIHostingController(rootView: screen),
            animated: true
        )
    }

    /// Pops all the view controllers on the current navigation stack and leaves only the root view controller.
    ///
    /// - Parameter animated: A Boolean value that indicates whether the transition should be animated.
    ///                      The default value is `true`.
    static func popToRootViewController(animated: Bool = true) {
        deVisibleViewController()?.navigationController?.popToRootViewController(animated: animated)
    }

    /// Close Keyboard if it is open
    /// - Returns:true if keyboard was closed, false if no keyboard was open
    @discardableResult
    static func closeKeyboard() -> Bool {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}

// MARK: - Status bar

extension UIApplication {

    var statusBarUIView: UIView? {
        let tag = 3848245
        let keyWindow = UIApplication.keyWindow

        if let statusBar = keyWindow.viewWithTag(tag) {
            return statusBar
        } else {
            let statusBarView = UIView(frame: UIApplication.statusBarFrame)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = CGFloat(UInt8.max)

            keyWindow.addSubview(statusBarView)
            return statusBarView
        }
    }
}

// MARK: - View Controller

extension UIApplication {

    class func getTopMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
}
