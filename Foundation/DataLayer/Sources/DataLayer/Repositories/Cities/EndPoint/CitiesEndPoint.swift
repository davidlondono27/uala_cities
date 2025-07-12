//
//  CitiesEndPoint.swift
//  DataLayer
//
//  Created by David Londono on 12/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Common
import Foundation
import Networking

enum CitiesEndPoint: APIEndpoint {
    case getCities

    var parameters: [String: Any]? {
        nil
    }

    // swiftlint: disable force_unwrapping
    var baseURL: URL {
        URL(string: "\(EnvironmentConfig.apiBaseUrl)/\(EndPoints.hernanUala)/\(EndPoints.baseCode)/\(EndPoints.citiesJson)")!
    }
    // swiftlint: enable force_unwrapping
    
    var path: String {
        switch self {
        case .getCities:
            return ""
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getCities:
            return .get
        }
    }

    var headers: [String: String]? {
        nil
    }
}
