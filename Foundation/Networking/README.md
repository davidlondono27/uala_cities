# Networking

## Introduction

The Networking module is responsible for handling all network communications within the application. This includes configuring HTTP clients, managing requests and responses, and handling errors and authentication. This module is designed to be reusable and maintainable.

## Main Components

### APIEndpoint

The `APIEndpoint` protocol defines the requirements for any API endpoint that needs to be consumed. This protocol includes properties for the base URL, the path, the HTTP method, and the request headers.

### NetworkService

`NetworkService` is a singleton class that handles network requests and returns responses. It uses the `APIEndpoint` protocol to construct requests and manage responses generically.

## Implementation Example

Below is an example of how to implement the `APIEndpoint` protocol and use `NetworkService` to perform a network request.

### Using NetworkService

```swift
struct ExampleEndpoint: APIEndpoint {
    var baseURL: URL {
        return URL(string: "https://api.example.com")!
    }

    var path: String {
        return "/example"
    }

    var method: String {
        return "POST"
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

struct ExampleResponse: Decodable {
    let id: Int
    let message: String
}

// Usage Example
let endpoint = ExampleEndpoint()
let response: ExampleResponse = try await NetworkService.shared.request(endpoint, as: ExampleResponse.self)
print(response)
```

## Conclusion

The Networking module is designed to be flexible and easy to use, allowing integration with any API endpoint following the APIEndpoint protocol. The NetworkService class centralizes network requests, making code management and maintenance easier.