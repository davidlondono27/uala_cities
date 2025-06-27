//
//  PermissionManaging.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

public enum PermissionsError: Error {
    case notImplemented
}

/// A protocol for managing multiple application permissions.
///
/// The `PermissionManaging` protocol defines methods for handling multiple application permissions.
/// It allows you to request all permissions, check the status of all permissions, check if a specific
/// permission is granted, and request a specific permission.
///
/// Example Usage:
/// ```swift
/// // Request all permissions
/// await permissionManager.requestAllPermissions()
///
/// // Check the status of all permissions
/// let permissionsStatus = permissionManager.checkAllPermissions()
///
/// // Check if a specific permission is granted
/// if permissionManager.checkIsGranted(permission: .location) {
///     // Location permission is granted.
/// }
///
/// // Request a specific permission
/// permissionManager.request(permission: .camera)
/// ```
///
/// - Note: Conform to this protocol to define the management of multiple application permissions.
///
/// - SeeAlso: `AppPermission`
public protocol PermissionManaging: AnyObject {
    /// Check the status of all permissions.
    ///
    /// - Returns: A dictionary containing the status of each permission.
    func checkAllPermissions() -> [AppPermission: Bool]

    /// Check if a specific permission is granted.
    ///
    /// - Parameters:
    ///   - permission: The permission to check.
    ///
    /// - Returns: A Boolean value indicating whether the permission is granted.
    func checkIsGranted(permission: AppPermission) -> Bool

    /// Request a specific permission asynchronously.
    ///
    /// - Parameters:
    ///   - permission: The permission to request.
    func request(permission: AppPermission) async

    /// Request a specific group of permission asynchronously.
    ///
    /// - Parameters:
    ///   - permissions: The permissions to request.
    func request(permissions: [AppPermission]) async

    /// Request all permissions asynchronously.
    func requestAllPermissions() async

    /// Request current permission status to handle different escenarios in the view
    /// - Parameters:
    ///   - permission: The permission to request.
    /// - Returns: The current status permission
    /// - Throws: PermissionsError
    func getStatus(for permission: AppPermission) async throws -> PermissionsStatus
}
