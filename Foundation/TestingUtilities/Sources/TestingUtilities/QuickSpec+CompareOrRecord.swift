//
//  QuickSpec+CompareOrRecord.swift
//  TestingUtilities
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation
import Nimble
import Nimble_Snapshots
import Quick
import SwiftUI

open class QuickSpecTestBase: QuickSpec { }

public extension QuickSpecTestBase {
    static func compareOrRecordSnapshot<V: SwiftUI.View>(
        _ view: V,
        isRecording: Bool,
        file: FileString = #file,
        line: UInt = #line
    ) {
        if isRecording {
            expect(file: file, view.window()).to(recordSnapshot())
        } else {
            expect(file: file, view.window())
                .to(
                    haveValidSnapshot(
                        pixelTolerance: Tolerance.defaultTolerance.rawValue,
                        tolerance: Tolerance.defaultTolerance.rawValue
                    )
                )
        }
    }
}
