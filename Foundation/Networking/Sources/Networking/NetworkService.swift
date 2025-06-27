//
//  NetworkService.swift
//  Networking
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation

struct NetworkService {
    /// The shared singleton instance of NetworkService.
    static let shared = NetworkService()

    /// Private initializer to enforce singleton pattern.
    private init() {}

    /**
     Makes a network request to the specified API endpoint and decodes the response into the specified type.
     
     - Parameters:
        - endpoint: The API endpoint to request.
        - type: The type to decode the response into.
     
     - Returns: The decoded response of the specified type.
     
     - Throws: An error if the request fails or the response cannot be decoded.
     
     Example usage:
     ```swift
     let response: ExampleResponse = try await NetworkService.shared.request(endpoint, as: ExampleResponse.self)
     print(response)
     ```
     */
    func request<T: Decodable>(_ endpoint: APIEndpoint, as type: T.Type) async throws -> T {
        // Perform the network request
        let (data, response) = try await URLSession.shared.data(for: endpoint.urlRequest)

        // Check the HTTP response status code
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        // Decode the response data into the specified type
        return try JSONDecoder().decode(T.self, from: data)
    }
}
