//
//  HomeViewModel.swift
//  FeatureDemo
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation
import DataLayer
import DomainLayer

final class HomeViewModel: HomeViewModelProtocol {
    private var repository: CitiesRepository
    
    init(
        repository: CitiesRepository = CitiesAPIRepository()
    ) {
        self.repository = repository
    }

    func onAppear() {
        Task {
            do {
                let cities = try await repository.getCities()
                print("Fetched cities:\n\(cities.count)")
            } catch {
                print("Cant fetch cities")
            }
        }
    }

}
