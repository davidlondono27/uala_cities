//
//  CitiesSearchEngine.swift
//  Common
//
//  Created by David Londono on 12/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import DomainLayer
import Foundation

public final class CitiesSearchEngine {
    private let indexedCities: [IndexedCity]

    public init(
        cities: [City]
    ) {
        self.indexedCities = cities.map { IndexedCity(city: $0) }
    }

    public func search(
        query: String,
        favorites: Set<Int> = [],
        showOnlyFavorites: Bool = false
    ) -> [City] {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        let results = indexedCities
            .filter { indexed in
                if normalizedQuery.isEmpty {
                    return false
                }
                let matches = indexed.searchKey.hasPrefix(normalizedQuery)
                return matches &&
                (!showOnlyFavorites || favorites.contains(indexed.city.id))
            }
            .map { $0.city }
        return results.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            || ($0.name == $1.name && $0.country < $1.country)
        }
    }
}
