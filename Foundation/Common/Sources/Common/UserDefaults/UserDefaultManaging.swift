//
//  UserDefaultManaging.swift
//  Common
//
//  Created by David Londono on 13/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import DomainLayer
import Foundation

public protocol UserDefaultManaging: AnyObject {
    func setFavoriteCityId(_ id: Int)
    func removeFavoriteCityId(_ id: Int)
    func getFavoriteCityIds() -> Set<Int>
    func isFavorite(_ id: Int) -> Bool
}
