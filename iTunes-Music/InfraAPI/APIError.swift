//
//  APIError.swift
//  iTunes-Music
//
//  Created by Magic Keegan on 2/4/23.
//

import Foundation

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String), parserError(reason: String), networkError(from: URLError)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason), .parserError(let reason):
            return reason
        case .networkError(let from):
            return from.localizedDescription
        }
    }
}
