//
//  DemoComponentTests.swift
//  uala_citiesUITests
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import SwiftUI
@testable import uala_citiesUI
import TestingUtilities

// swiftlint:disable static_over_final_class
final class DemoComponentTests: QuickSpecTestBase {
    override class func spec() {
        let isRecording: Bool = false
        describe("DemoComponent") {
            context("should have expected layout when") {
                beforeEach {
                }
                it("init") {
                    let sut = DemoComponent()
                    compareOrRecordSnapshot(sut, isRecording: isRecording)
                }
                afterEach {
                }
            }
        }
    }
}
// swiftlint:enable static_over_final_class
