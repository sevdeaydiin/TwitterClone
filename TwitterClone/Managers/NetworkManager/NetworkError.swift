//
//  NetworkError.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case failedResponse(statusCode: Int)
    case rateLimitExceeded
    case decodeFailed(errorDescription: String)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            "Invalid URL Error Check Your URL"
        case .invalidResponse:
            "Invalid Response Check Your Request"
        case .failedResponse(let statusCode):
            "Failed Response With StatusCode: \(statusCode)"
        case .rateLimitExceeded:
            "Rate Limit Exceeded You Can Try Again Later"
        case .decodeFailed(let decodeErrorDescription):
            "Decode Failed With DecodeError: \n\(decodeErrorDescription)\n"
        }
    }
}
