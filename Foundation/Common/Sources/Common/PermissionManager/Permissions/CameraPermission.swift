//
//  CameraPermission.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import AVFoundation

final class CameraPermission: Permission {
    var type: AppPermission = .camera

    func requestPermission() async -> Bool {
        await AVCaptureDevice.requestAccess(for: .video)
    }

    func isPermissionGranted() -> Bool {
        AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    func status() async -> PermissionsStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .neverAsked
        default:
            return .denied
        }
    }
}
