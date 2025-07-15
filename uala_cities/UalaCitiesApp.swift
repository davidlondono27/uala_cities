//
//  UalaCitiesApp.swift
//  uala_cities
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Home
import SwiftUI

@main
struct UalaCitiesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            Home.start()
        }
    }
}
