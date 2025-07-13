//
//  CitiesRepository.swift
//  DataLayer
//
//  Created by David Londono on 12/07/25.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation
import DomainLayer

public protocol CitiesRepository: AnyObject {
    func getCities() async throws -> [Cities]
}
