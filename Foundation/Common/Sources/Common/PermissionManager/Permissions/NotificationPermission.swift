//
//  NotificationPermission.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import UserNotifications

/// A class for managing Notification permission.
///
/// The `NotificationPermission` class is responsible for managing Notification permission. It allows
/// you to request this permission asynchronously and check if it is granted.
///
/// Example Usage:
/// ```swift
/// let notificationPermission = NotificationPermission()
///
/// if await notificationPermission.requestPermission() {
///     // Notification permission granted, proceed with notification-related tasks.
/// } else {
///     // Notification permission not granted, handle accordingly.
/// }
/// ```
///
/// - Note: This class conforms to the `Permission` protocol and is designed for handling Notification permission.
///
/// - SeeAlso: `Permission`, `AppPermission`
final class NotificationPermission: Permission {
    private typealias NotificationCheckedContinuation = CheckedContinuation<Bool, Never>

    /// The type of the application permission, which is Notification.
    var type: AppPermission = .notifications
    private var isGranted: Bool = false
    private let center = UNUserNotificationCenter.current()

    /// Request the Notification permission asynchronously.
    ///
    /// - Returns: A Boolean value indicating whether the permission was granted.
    func requestPermission() async -> Bool {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        return (try? await center.requestAuthorization(options: authOptions)) ?? false
    }

    // Check if the Notification permission is granted.
    ///
    /// - Returns: A Boolean value indicating whether the permission is granted.
    func isPermissionGranted() -> Bool {
        Task.synchronous { [weak self] in
            guard let self else { return }
            self.isGranted = await self.checkIsPermissionGranted()
        }
        return isGranted
    }

    private func checkIsPermissionGranted() async -> Bool {
        await withCheckedContinuation({ [weak self] (continuation: NotificationCheckedContinuation) in
            guard let self = self else {
                continuation.resume(returning: false)
                return
            }
            self.center.getNotificationSettings { (settings) in
                continuation.resume(returning: settings.authorizationStatus == .authorized)
            }
        })
    }

    /// Get current App Transparency Tracking permission state
    /// - Returns: .authorized, .denied, .neverAsked and .temporalAuthorized
    func status() async -> PermissionsStatus {
        let settings = await self.center.notificationSettings()
        switch settings.authorizationStatus {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .neverAsked
        case .provisional, .ephemeral:
            return .temporalAuthorized
        default:
            return .denied
        }
    }
}
