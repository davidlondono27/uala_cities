//
//  PermissionManager.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import UIKit

public class PermissionManager: PermissionManaging {
    private var permissions: [Permission]
    public static let shared = PermissionManager()

    private init() {
        permissions = [
            ATTrackingPermission(),
            NotificationPermission(),
            CameraPermission(),
            LocationPermission()
        ]
    }

    public func checkAllPermissions() -> [AppPermission: Bool] {
        permissions.reduce(into: [AppPermission: Bool]()) {
            $0[$1.type] = $1.isPermissionGranted()
        }
    }

    public func checkIsGranted(permission: AppPermission) -> Bool {
        permissions.first(where: { $0.type == permission })?.isPermissionGranted() ?? false
    }

    public func requestAllPermissions() async {
        let all = permissions.compactMap({ $0.type })
        await request(permissions: all)
    }

    public func request(permissions: [AppPermission]) async {
        // swiftlint:disable line_length
        /**
         Calls to the API only prompt when the application state is UIApplicationStateActive.
         For more information: https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization
         */
        let state = await UIApplication.shared.applicationState
        guard state == .active else { return }
        let permissionToRequest = self.permissions.filter({ permissions.contains($0.type) })
        /// Using for in instead of .foreach because we need to await for async methods because
        /// the authorization prompt doesn’t display if another permission request is pending user confirmation.
        /// https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization
        for permission in permissionToRequest {
            _ = await permission.requestPermission()
        }
        // swiftlint:enable line_length
    }

    public func request(permission: AppPermission) async {
        guard let permissionObj = permissions.first(where: { $0.type == permission }) else {
            return
        }
        _ = await permissionObj.requestPermission()
    }

    public func getStatus(for permission: AppPermission) async throws -> PermissionsStatus {
        guard let permissionObj = permissions.first(where: { $0.type == permission }) else {
            throw PermissionsError.notImplemented
        }
        return await permissionObj.status()
    }
}
