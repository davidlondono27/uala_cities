//
//  Device.swift
//  TestingUtilities
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation
import UIKit

/// Representation of a test device
public enum Device: String, RawRepresentable {
    case iphoneSE
    case iphone8
    case iphoneX
    case agnosticDevice

    /// Device size
    public var size: CGSize {
        switch self {
        case .iphoneSE:
            return CGSize(width: 320.0, height: 568.0)
        case .iphone8:
            return CGSize(width: 375.0, height: 667.0)
        case .iphoneX:
            return CGSize(width: 375.0, height: 812.0)
        case .agnosticDevice:
            return CGSize(width: 375.0, height: 0)
        }
    }

    /// Dictionary representation of a device with its size
    public var sizeDict: [String: CGSize] {
        [self.rawValue: self.size]
    }

    /// Default dictionary with the most used sizes
    public static let sizes: [String: CGSize] = {
        [Device.iphoneX.rawValue: Device.iphoneX.size]
    }()

    /**
        Get a dictionary with a custom device and size
        - Parameter height: device height
        - Returns: a dictionary with a representation of a custom device and size
     */
    public static func sizeWith(height: CGFloat) -> [String: CGSize] {
        [Device.agnosticDevice.rawValue: CGSize(width: Device.iphoneX.size.width,
                                                height: height)]
    }
}
