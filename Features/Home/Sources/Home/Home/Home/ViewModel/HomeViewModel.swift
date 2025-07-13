//
//  HomeViewModel.swift
//  FeatureDemo
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Common
import DataLayer
import DomainLayer
import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    private var repository: CitiesRepository
    private var searchEngine: CitiesSearchEngine?
    private var favorites: Set<Int> = []
    
    @Published var filteredCities: [City] = []
    @Published var filterText: String = "" {
        didSet { updateFilteredCities() }
    }
    @Published var showOnlyFavorites: Bool = false {
        didSet { updateFilteredCities() }
    }

    init(
        repository: CitiesRepository = CitiesAPIRepository()
    ) {
        self.repository = repository
    }

    func onAppear() {
        Task { @MainActor in
            do {
                let cities = try await repository.getCities()
                self.searchEngine = CitiesSearchEngine(cities: cities)
                updateFilteredCities()
            } catch {
                debugPrint("Cant fetch cities")
            }
        }
    }

    func didTapCleanAll() {
        Task { @MainActor in
            filterText = ""
        }
    }

    private func updateFilteredCities() {
        guard let searchEngine else {
            filteredCities = []
            return
        }
        Task { @MainActor in
            filteredCities = searchEngine.search(
                query: filterText,
                favorites: favorites,
                showOnlyFavorites: showOnlyFavorites
            )
        }
    }
}
