//
//  CitiesSearchEngineTests.swift
//  Common
//
//  Created by David Londono on 12/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

@testable import Common
import DomainLayer
import XCTest

final class CitiesSearchEngineTests: XCTestCase {

    private var engine: CitiesSearchEngine!

    private let sampleCities: [City] = [
        .init(id: 1, country: "US", name: "Albuquerque", coordinates: .init(latitude: 0, longitude: 0)),
        .init(id: 2, country: "US", name: "Alabama", coordinates: .init(latitude: 0, longitude: 0)),
        .init(id: 3, country: "AU", name: "Sydney", coordinates: .init(latitude: 0, longitude: 0)),
        .init(id: 4, country: "US", name: "Anaheim", coordinates: .init(latitude: 0, longitude: 0)),
        .init(id: 5, country: "US", name: "Arizona", coordinates: .init(latitude: 0, longitude: 0)),
        .init(id: 6, country: "FR", name: "Paris", coordinates: .init(latitude: 0, longitude: 0)),
    ]

    override func setUp() {
        super.setUp()
        engine = CitiesSearchEngine(cities: sampleCities)
    }

    func test_search_returnsCitiesMatchingPrefix_caseInsensitive() {
        let results = engine.search(query: "a")
        let names = results.map(\.name)
        XCTAssertEqual(names, ["Alabama", "Albuquerque", "Anaheim", "Arizona"])
    }

    func test_search_withExactPrefix_returnsOnlyMatching() {
        let results = engine.search(query: "Alb")
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.name, "Albuquerque")
    }

    func test_search_returnsNothingWhenNoMatch() {
        let results = engine.search(query: "xyz")
        XCTAssertTrue(results.isEmpty)
    }

    func test_search_respectsFavoritesFilter() {
        let results = engine.search(query: "a", favorites: [2, 4], showOnlyFavorites: true)
        let names = results.map(\.name)
        XCTAssertEqual(names, ["Alabama", "Anaheim"])
    }
}
