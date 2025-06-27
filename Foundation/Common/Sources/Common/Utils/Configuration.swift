//
//  Configuration.swift
//  Common
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation

struct Configuration {
    static func value(for key: String) -> String {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) as? String else { return "" }
        return object
    }
}
