//
//  HomeViewModelProtocol.swift
//  FeatureDemo
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Combine
import DomainLayer

protocol HomeViewModelProtocol: AnyObject, ObservableObject {
    var filteredCities: [City] { get set }
    var filterText: String { get set }
    var showOnlyFavorites: Bool { get set }

    func onAppear()
    func didTapCleanAll()
}
