//
//  SnapshotTestBase.swift
//  TestingUtilities
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation
import Nimble
import Nimble_Snapshots
import SwiftUI
import UIKit
import XCTest

/**
 Base Snapshot test case.

 This class was thought to be used with `NimbleSnapshots` library.
 */
open class SnapshotTestBase: XCTestCase {
    // swiftlint:disable implicitly_unwrapped_optional
    /// UIWindows used to host the presenting view controller
    public var window: UIWindow!
    // swiftlint:enable implicitly_unwrapped_optional

    @available(*, unavailable)
    override open func setUp() {}

    @available(*, unavailable)
    override open func tearDown() {}

    /// Init the `window` instance before the test case run
    @MainActor
    override open func setUpWithError() throws {
        try super.setUpWithError()
        self.window = UIWindow.deviceFrame()
    }

    /// Deinit the `window` instance after the test case run
    @MainActor
    override open func tearDownWithError() throws {
        try super.tearDownWithError()
        self.window = nil
    }

    public func runExpectation(file: FileString = #file,
                               view: some View,
                               sizes: [String: CGSize] = Device.sizes,
                               tolerance: Tolerance = Tolerance.noTolerance,
                               isRecording: Bool = false,
                               timeOut: NimbleTimeInterval? = nil,
                               showTestWindow: Bool = true) {
        if showTestWindow {
            let controller = view.hostingController
            self.window.showTestWindow(controller: controller)
        }
        if isRecording {
            recordSnapshot(file: file, sizes: sizes, timeOut: timeOut)
        } else {
            assertSnapshot(file: file, sizes: sizes, tolerance: tolerance, timeOut: timeOut)
        }
    }

    public func assertSnapshot(
        file: FileString,
        sizes: [String: CGSize],
        tolerance: Tolerance,
        timeOut: NimbleTimeInterval? = nil
    ) {
        if let timeOut = timeOut {
            expect(file: file, self.window).toEventually(
                haveValidDynamicSizeSnapshot(
                    sizes: sizes,
                    tolerance: tolerance.rawValue
                ),
                timeout: timeOut
            )
            return
        }
        expect(file: file, self.window).to(
            haveValidDynamicSizeSnapshot(
                sizes: sizes,
                tolerance: tolerance.rawValue
            )
        )
    }

    public func recordSnapshot(file: FileString, sizes: [String: CGSize], timeOut: NimbleTimeInterval? = nil) {
        if let timeOut = timeOut {
            expect(file: file, self.window).toEventually(
                recordDynamicSizeSnapshot(
                    sizes: sizes
                ),
                timeout: timeOut
            )
            return
        }
        expect(file: file, self.window).to(
            recordDynamicSizeSnapshot(
                sizes: sizes
            )
        )
    }
}

public enum Tolerance: CGFloat {
    case defaultTolerance = 0.01
    case noTolerance = 0.0
}

public extension DispatchTimeInterval {
    var nimbleTimeInterval: NimbleTimeInterval {
        switch self {
        case .seconds(let value):
            return .seconds(value)
        case .milliseconds(let value):
            return .milliseconds(value)
        case .microseconds(let value):
            return .microseconds(value)
        default:
            return .seconds(0)
        }
    }
}
