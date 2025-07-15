//
//  UserDefaultsWrapper.swift
//  Common
//
//  Created by David Londono on 13/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation

final class UserDefaultsWrapper {
    /// Stores a value in UserDefaults for a specific key.
    ///
    /// - Parameters:
    ///   - value: The value to store. Can be any type supported by `UserDefaults` or conforming to `Codable`.
    ///   - key: The key under which to store the value.
    ///   - Returns: `true` if the operation was successful, `false` in case of error.
    @discardableResult static func set<T: Codable>(value: T, forKey key: String) -> Bool {
        let defaults = UserDefaults.standard

        if let array = value as? [Any], array.first is Codable {
            do {
                let encoded = try JSONEncoder().encode(value)
                defaults.set(encoded, forKey: key)
                return true
            } catch {
                return false
            }
        }

        if value is String ||
            value is Int ||
            value is Double ||
            value is Float ||
            value is Bool ||
            value is Data ||
            value is [Any] ||
            value is [String: Any] {
            defaults.set(value, forKey: key)
            return true
        }

        do {
            let encoded = try JSONEncoder().encode(value)
            defaults.set(encoded, forKey: key)
            return true
        } catch {
            return false
        }
    }

    /// Retrieves a value from UserDefaults for a specific key.
    ///
    /// - Parameters:
    ///   - key: The key of the value to retrieve.
    ///   - type: The expected type of the value (for `Codable` objects).
    ///   - Returns: The retrieved value, or `nil` if it doesn't exist or is not of the expected type.
    static func get<T: Codable>(key: String, as type: T.Type) -> T? {
        let defaults = UserDefaults.standard

        if let data = defaults.data(forKey: key) {
            do {
                let decoded = try JSONDecoder().decode(type, from: data)
                return decoded
            } catch {
                return nil
            }
        }

        return defaults.object(forKey: key) as? T
    }

    /// Deletes a value from UserDefaults for a specific key.
    ///
    /// - Parameter key: The key of the value to delete.
    /// - Returns: `true` if the operation was successful.
    @discardableResult static func delete(key: String) -> Bool {
        UserDefaults.standard.removeObject(forKey: key)
        return true
    }

    /// Clears all values stored in UserDefaults.
    ///
    /// Use this method with caution, as it removes everything stored by the app.
    static func clearAll() {
        guard let bundleId = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleId)
        UserDefaults.standard.synchronize()
    }
}
