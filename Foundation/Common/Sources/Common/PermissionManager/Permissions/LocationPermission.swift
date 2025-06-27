//
//  LocationPermission.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import CoreLocation
import Foundation

final class LocationPermission: NSObject, Permission {
    var type: AppPermission = .location

    private typealias LocationPermissionThrowingContinuation = CheckedContinuation<Bool, Error>

    private var locationPermissionThrowingContinuation: LocationPermissionThrowingContinuation?

    fileprivate var locationManager = CLLocationManager()
    private let locationAuthorized = [CLAuthorizationStatus.authorizedAlways, CLAuthorizationStatus.authorizedWhenInUse]

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestPermission() async -> Bool {
        guard locationManager.authorizationStatus == .notDetermined else {
            return isPermissionGranted()
        }

        return (try? await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else { return }
            self.locationPermissionThrowingContinuation = continuation
            self.locationManager.requestWhenInUseAuthorization()
        }) ?? false
    }

    func isPermissionGranted() -> Bool {
         isAuthorized(authorizationStatus: locationManager.authorizationStatus)
    }

    private func isAuthorized(authorizationStatus: CLAuthorizationStatus) -> Bool {
        locationAuthorized.contains(authorizationStatus)
    }

    func status() async -> PermissionsStatus {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            return .neverAsked
        case .denied:
            return .denied
        case .restricted, .authorizedAlways, .authorizedWhenInUse:
            return .authorized
        default:
            return .denied
        }
    }
}

extension LocationPermission: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus != .notDetermined else {
            return
        }
        locationPermissionThrowingContinuation?.resume(
            returning: isAuthorized(
                authorizationStatus: manager.authorizationStatus
            )
        )
        locationPermissionThrowingContinuation = nil
    }
}
