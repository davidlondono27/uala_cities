//
//  IndexedCity.swift
//  Common
//
//  Created by David Londono on 12/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import DomainLayer
import Foundation

public struct IndexedCity {
    let city: City
    let searchKey: String
    
    init(city: City) {
        self.city = city
        self.searchKey = city.name.lowercased()
    }
}
