//
//  APIEndpoint.swift
//  Networking
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation

/// A protocol representing the essential properties and methods for defining an API endpoint.
protocol APIEndpoint {
    /// The base URL of the API endpoint.
    var baseURL: URL { get }

    /// The specific path of the API endpoint, appended to the base URL.
    var path: String { get }

    /// The HTTP method to be used for the API request (e.g., "GET", "POST").
    var method: String { get }

    /// The headers to be included in the API request.
    var headers: [String: String]? { get }

    /// The parameters to be included in the body of the API request.
    var parameters: [String: Any]? { get }

    /// A computed property that generates a URLRequest based on the other properties.
    var urlRequest: URLRequest { get }
}

/// An extension of the APIEndpoint protocol to provide a default implementation for generating a URLRequest.
extension APIEndpoint {
    var urlRequest: URLRequest {
        // Create a URL by appending the path to the base URL.
        var request = URLRequest(url: baseURL.appendingPathComponent(path))

        // Set the HTTP method for the request.
        request.httpMethod = method

        // Add the headers to the request.
        request.allHTTPHeaderFields = headers

        // If parameters are provided, serialize them to JSON and set them as the HTTP body.
        if let params = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }

        // Return the configured URLRequest.
        return request
    }
}

/// Example implementation of the APIEndpoint protocol
/// ```swift
/// struct ExampleEndpoint: APIEndpoint {
///     var baseURL: URL {
///         return URL(string: "https://api.example.com")!
///     }
///
///     var path: String {
///         return "/example"
///     }
///
///     var method: String {
///         return "POST"
///     }
///
///     var headers: [String : String]? {
///         return ["Content-Type": "application/json"]
///     }
///
