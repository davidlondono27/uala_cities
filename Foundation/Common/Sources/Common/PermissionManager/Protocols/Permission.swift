//
//  Permission.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

public enum PermissionsStatus {
    case authorized
    case denied
    case neverAsked
    case temporalAuthorized
}

/// A protocol for managing application permissions.
///
/// The `Permission` protocol defines a set of methods for managing various application permissions.
/// It allows you to request permissions asynchronously and check if a permission has been granted.
///
/// Example Usage:
/// ```swift
/// if await locationPermission.requestPermission() {
///     // Location permission granted, proceed with location-based tasks.
/// } else {
///     // Location permission not granted, handle accordingly.
/// }
/// ```
///
/// - Note: Conform to this protocol to define and manage specific application permissions.
///
/// - SeeAlso: `AppPermission`
protocol Permission: AnyObject {
    /// The type of the application permission.
    var type: AppPermission { get }

    /// Request the permission asynchronously.
    ///
    /// - Returns: A Boolean value indicating whether the permission was granted.
    func requestPermission() async -> Bool

    /// Check if the permission is granted.
    ///
    /// - Returns: A Boolean value indicating whether the permission is granted.
    func isPermissionGranted() -> Bool

    /// Returns current permissions state
    ///
    /// - Returns: The current authorization state of this permission
    func status() async -> PermissionsStatus
}
