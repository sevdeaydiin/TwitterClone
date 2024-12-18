//
//  MockNetworkManager.swift
//  TwitterCloneTests
//
//  Created by Sevde Aydın on 12/18/24.
//

import Foundation
@testable import TwitterClone

final class MockNetworkManager: NetworkService {
    var shouldFail: Bool = false
    var mockData: Data?
    
    func fetch<T: Decodable>(with endpoint: any Endpoint) async throws -> T {
        if shouldFail {
            throw NetworkError.failedResponse(statusCode: -1)
        }
        
        guard let _ = endpoint.createURLRequest() else {
            throw NetworkError.invalidURL
        }
        
        guard let mockData = mockData else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let simulatedResponse = try JSONDecoder().decode(T.self, from: mockData)
            return simulatedResponse
        } catch {
            throw NetworkError.decodeFailed(errorDescription: "Decode Failed \(error.localizedDescription)")
        }
    }
}
