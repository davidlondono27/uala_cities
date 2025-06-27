//
//  ATTrackingPermission.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import AppTrackingTransparency
import UIKit

/// A class for managing App Transparency Tracking permission.
///
/// The `ATTrackingPermission` class is responsible for managing App Transparency Tracking permission.
/// It allows you to request this permission asynchronously and check if it is granted.
///
/// Example Usage:
/// ```swift
/// let trackingPermission = ATTrackingPermission()
///
/// if await trackingPermission.requestPermission() {
///     // App Transparency Tracking permission granted, proceed with tracking-related tasks.
/// } else {
///     // App Transparency Tracking permission not granted, handle accordingly.
/// }
/// ```
///
/// - Note: This class conforms to the `Permission` protocol and is specifically designed for handling
///   the App Transparency Tracking permission.
///
/// - SeeAlso: `Permission`, `AppPermission`
final class ATTrackingPermission: Permission {
    /// The type of the application permission, which is App Transparency Tracking.
    var type: AppPermission = .appTransparencyTracking

    /// Request the App Transparency Tracking permission asynchronously.
    ///
    /// - Returns: A Boolean value indicating whether the permission was granted.
    func requestPermission() async -> Bool {
        let isEnabled = isPermissionGranted()
        guard !isEnabled else { return isEnabled }
        let status = await ATTrackingManager.requestTrackingAuthorization()
        /// This is a workaround for this bug - https://forums.developer.apple.com/forums/thread/746432
        if status == .denied, ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
            /// iOS 17.4 ATT bug detected
            for await _ in NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                return await ATTrackingManager.requestTrackingAuthorization() == .authorized
            }
        }
        return status == .authorized
    }

    /// Check if the App Transparency Tracking permission is granted.
    ///
    /// - Returns: A Boolean value indicating whether the permission is granted.
    func isPermissionGranted() -> Bool {
        ATTrackingManager.trackingAuthorizationStatus == .authorized
    }

    /// Get current App Transparency Tracking permission state
    /// - Returns: .authorized, .denied, .neverAsked and .temporalAuthorized
    func status() async -> PermissionsStatus {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .neverAsked
        default:
            return .denied
        }
    }
}
