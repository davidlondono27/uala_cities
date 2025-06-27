//
//  AppPermission.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

/// An enumeration representing various application permissions.
///
/// The `AppPermission` enum defines cases for different types of application permissions, such as location,
/// app transparency tracking, camera, and notifications.
///
/// Example Usage:
/// ```swift
/// if permission == .camera {
///     // Handle camera-related tasks.
/// }
/// ```
///
/// - Note: This enum is used to represent and manage different application permissions in an application.
public enum AppPermission {
    /// Permission for accessing the device's location.
    case location

    /// Permission for app transparency tracking, typically related to user privacy.
    case appTransparencyTracking

    /// Permission for accessing the device's camera.
    case camera

    /// Permission for sending notifications to the user.
    case notifications
}
