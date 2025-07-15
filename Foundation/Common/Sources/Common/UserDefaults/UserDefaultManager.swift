//
//  UserDefaultManager.swift
//  Common
//
//  Created by David Londono on 13/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import DomainLayer
import Foundation

public final class UserDefaultManager: UserDefaultManaging {
    enum UserDefaultsKey {
        static let favoriteCities: String = "favorite_city_ids"
    }

    public init() {}

    public func setFavoriteCityId(_ id: Int) {
        var ids = getFavoriteCityIds()
        ids.insert(id)
        UserDefaultsWrapper.set(value: Array(ids), forKey: UserDefaultsKey.favoriteCities)
    }

    public func removeFavoriteCityId(_ id: Int) {
        var ids = getFavoriteCityIds()
        ids.remove(id)
        UserDefaultsWrapper.set(value: Array(ids), forKey: UserDefaultsKey.favoriteCities)
    }

    public func getFavoriteCityIds() -> Set<Int> {
        let array = UserDefaultsWrapper.get(key: UserDefaultsKey.favoriteCities, as: [Int].self) ?? []
        return Set(array)
    }

    public func isFavorite(_ id: Int) -> Bool {
        getFavoriteCityIds().contains(id)
    }
}
