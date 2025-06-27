//
//  View+UIHostingController.swift
//  TestingUtilities
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

public extension View {
    /// Get and instance of `UIHostingViewController` with this view as root view
    var hostingController: UIHostingController<some View> {
        UIHostingController(rootView: self)
    }

    /// Helper function for view snapshots
    /// - Parameters:
    ///   - device: defaults to iphoneX
    ///   - colorScheme: light or dark
    /// - Returns: a UIView
    func window(device: Device = .iphoneX, colorScheme: ColorScheme? = nil) -> UIWindow {
        let viewController = UIHostingController(rootView: self.environment(\.colorScheme, colorScheme ?? .light))
        viewController._disableSafeArea = true

        let window = UIWindow(frame: CGRect(origin: .zero, size: device.size))
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        window.backgroundColor = colorScheme == .light ? .white : .black

        return window
    }

    func adaptableView(size: CGSize, colorScheme: ColorScheme? = nil) -> UIView {
        let viewController = UIHostingController(rootView: self.environment(\.colorScheme, colorScheme ?? .light))
        viewController._disableSafeArea = true

        let window = UIWindow(frame: CGRect(origin: .zero, size: size))
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        window.backgroundColor = colorScheme == .light ? .white : .black

        return window
    }

    /// Helper function for view snapshots
    /// - Parameters:
    ///   - device: defaults to iphone13Pro
    ///   - colorScheme: light or dark
    /// - Returns: a UIView
    func controller(device: Device = .agnosticDevice, colorScheme: ColorScheme? = nil) -> UIViewController {
        let viewController = UIHostingController(rootView: self.environment(\.colorScheme, colorScheme ?? .light))
        viewController._disableSafeArea = false

        let window = UIWindow(frame: CGRect(origin: .zero, size: device.size))
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        window.backgroundColor = colorScheme == .light ? .white : .black

        return viewController
    }
}
