//
//  APIError.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Foundation

enum APIError: LocalizedError {
    case network(Error)
    case custom(reason: String)
    case missingData
    case jsonParsingError
    case unknown
    // Can be added more error type
    var errorDescription: String? {
        switch self {
        case let .network(error):
            return error.localizedDescription
        case let .custom(reason):
            return reason
        case .unknown,
                .jsonParsingError,
                .missingData:
            return "Something bad happened. Please try again."
        }
    }
}
