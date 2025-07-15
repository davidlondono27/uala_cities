//
//  CitiesAPIResponse.swift
//  DataLayer
//
//  Created by David Londono on 06/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import DomainLayer

// MARK: - City
struct CitiesAPIResponse: Codable {
    let id: Int
    let country: String
    let name: String
    let coord: CityAPICoord

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

// MARK: - CityCoord
struct CityAPICoord: Codable {
    let lon: Double
    let lat: Double
}

extension CitiesAPIResponse {
    func mapToModel() -> City {
        City(
            id: id,
            country: country,
            name: name,
            coordinates: CityCoordinate(
                latitude: coord.lat,
                longitude: coord.lon
            )
        )
    }
}
