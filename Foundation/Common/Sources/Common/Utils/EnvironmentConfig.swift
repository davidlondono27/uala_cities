//
//  Environment.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation

public struct EnvironmentConfig {
    public static var apiBaseUrl: String {
        Configuration.value(for: "API_BASE_URL")
    }
}
