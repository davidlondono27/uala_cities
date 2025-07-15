//
//  CitiesAPIRepository.swift
//  DataLayer
//
//  Created by David Londono on 12/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Common
import DomainLayer
import Foundation
import Networking

public final class CitiesAPIRepository: CitiesRepository {
    private var networkService = NetworkService.shared

    public init() {}

    public func getCities() async throws -> [City] {
        let endPoint = CitiesEndPoint.getCities

        let response = try await networkService.request(endPoint, as: [CitiesAPIResponse].self)
        let cities = response.map { $0.mapToModel() }
        return cities
    }
}
