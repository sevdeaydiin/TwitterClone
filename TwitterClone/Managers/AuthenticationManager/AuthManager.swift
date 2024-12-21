//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/19/24.
//

import Foundation

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> ApiResponse
    func register(username: String, email: String, password: String) async throws -> ApiResponse
    func fetchUser(userId: String) async throws -> ApiResponse
}
 
final class AuthManager: AuthServiceProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func login(email: String, password: String) async throws -> ApiResponse {
            do {
                let endpoint = UserEndpoint.loginUser(email: email, password: password)
                return try await networkService.fetch(with: endpoint)
            } catch {
                // Hatanın türüne göre daha spesifik hatalar fırlatabilirsin
                if let networkError = error as? NetworkError {
                    throw networkError // NetworkError'ı olduğu gibi fırlat
                } else {
                    throw NetworkError.unknownError // Bilinmeyen hata
                }
            }
        }
    
    func register(username: String, email: String, password: String) async throws -> ApiResponse {
        let endpoint = UserEndpoint.registerUser(username: username, email: email, password: password)
        return try await networkService.fetch(with: endpoint)
    }
    
    func fetchUser(userId: String) async throws -> ApiResponse {
        let endpoint = UserEndpoint.getUser(userId: userId)
        return try await networkService.fetch(with: endpoint)
    }
    
}
