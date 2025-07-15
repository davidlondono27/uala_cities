//
//  HomeViewTests.swift
//  FeatureDemoTests
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

@testable import Home
import SwiftUI
import TestingUtilities

// swiftlint:disable static_over_final_class
final class HomeViewTests: QuickSpecTestBase {
    override class func spec() {
        let isRecording: Bool = false
        describe("HomeView") {
            context("should have expected layout when") {
                it("init") {
                    let viewModel = HomeViewModel()
                    let sut = HomeView(viewModel: viewModel)
                    compareOrRecordSnapshot(sut, isRecording: isRecording)
                }
            }
        }
    }
}
// swiftlint:enable static_over_final_class
