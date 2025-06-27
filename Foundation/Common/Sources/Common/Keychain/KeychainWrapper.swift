//
//  KeychainWrapper.swift
//  KeychainWrapper
//
//  Created by Jason Rendel on 09/23/2014.
//  Copyright © 2014 Jason Rendel. All rights reserved.
//
//    The MIT License (MIT)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import Foundation
import Security

// swiftlint:disable non_optional_string_data_conversion
/// A simple wrapper around the iOS Keychain to securely store, retrieve, update, and delete sensitive information.
class KeychainWrapper {
    /// Stores a value in the Keychain for a given key.
    ///
    /// - Parameters:
    ///   - value: The string value to store in the Keychain.
    ///   - key: The key under which to store the value.
    /// - Returns: A boolean indicating whether the value was successfully stored.
    ///
    /// # Example #
    /// ```
    /// let success = KeychainWrapper.set(value: "my_secret_password", forKey: "user_password")
    /// if success {
    ///     print("Password saved successfully.")
    /// } else {
    ///     print("Failed to save password.")
    /// }
    /// ```
    @discardableResult class func set(value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        // Delete any existing item before adding a new one
        delete(key: key)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    /// Retrieves a value from the Keychain for a given key.
    ///
    /// - Parameter key: The key whose corresponding value you want to retrieve.
    /// - Returns: The string value associated with the key, or `nil` if the value does not exist.
    ///
    /// # Example #
    /// ```
    /// if let password = KeychainWrapper.get(key: "user_password") {
    ///     print("Retrieved password: \(password)")
    /// } else {
    ///     print("Failed to retrieve password.")
    /// }
    /// ```
    class func get(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess, let data = dataTypeRef as? Data else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    /// Deletes a value from the Keychain for a given key.
    ///
    /// - Parameter key: The key whose corresponding value you want to delete.
    /// - Returns: A boolean indicating whether the value was successfully deleted.
    ///
    /// # Example #
    /// ```
    /// let success = KeychainWrapper.delete(key: "user_password")
    /// if success {
    ///     print("Password deleted successfully.")
    /// } else {
    ///     print("Failed to delete password.")
    /// }
    /// ```
    @discardableResult class func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }

    /// Updates an existing value in the Keychain for a given key.
    ///
    /// - Parameters:
    ///   - value: The new string value to store in the Keychain.
    ///   - key: The key under which to update the value.
    /// - Returns: A boolean indicating whether the value was successfully updated.
    ///
    /// # Example #
    /// ```
    /// let success = KeychainWrapper.update(value: "new_secret_password", forKey: "user_password")
    /// if success {
    ///     print("Password updated successfully.")
    /// } else {
    ///     print("Failed to update password.")
    /// }
    /// ```
    @discardableResult class func update(value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        return status == errSecSuccess
    }

    /// Clears all items stored in the Keychain.
    ///
    /// Use this method with caution as it will remove all keychain items for the app.
    ///
    /// # Example #
    /// ```
    /// KeychainWrapper.clearAll()
    /// print("All keychain items cleared.")
    /// ```
    class func clearAll() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]

        SecItemDelete(query as CFDictionary)
    }
}
// swiftlint:enable non_optional_string_data_conversion
