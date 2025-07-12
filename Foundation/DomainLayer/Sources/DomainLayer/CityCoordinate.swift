//
//  CityCoordinate.swift
//  DomainLayer
//
//  Created by David Londono on 12/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation

public struct CityCoordinate {
    public let latitude: Double
    public let longitude: Double
    
    public init(
        latitude: Double,
        longitude: Double
    ) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
