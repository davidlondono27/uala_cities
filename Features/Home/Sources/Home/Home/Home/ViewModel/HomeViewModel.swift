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
    private var userDefault: UserDefaultManaging = UserDefaultManager()
    @Published private(set) var favorites: Set<Int>
    
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
        self.favorites = userDefault.getFavoriteCityIds()
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

    func isFavorite(_ city: City) -> Bool {
        favorites.contains(city.id)
    }

    func didTapFavorite(_ city: City) {
        if favorites.contains(city.id) {
            favorites.remove(city.id)
            userDefault.removeFavoriteCityId(city.id)
        } else {
            favorites.insert(city.id)
            userDefault.setFavoriteCityId(city.id)
        }
        updateFilteredCities()
    }

    private func updateFilteredCities() {
        favorites = userDefault.getFavoriteCityIds()
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
