//
//  City.swift
//  DomainLayer
//
//  Created by David Londono on 12/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation

public struct City: Identifiable, Hashable {
    public let id: Int
    public let country, name: String
    public let coordinates: CityCoordinate

    public init(
        id: Int,
        country: String,
        name: String,
        coordinates: CityCoordinate
    ) {
        self.id = id
        self.country = country
        self.name = name
        self.coordinates = coordinates
    }
}

public extension City {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
}
