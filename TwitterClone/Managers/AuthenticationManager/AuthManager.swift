//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/19/24.
//

import Foundation

protocol AuthService {
    func login(email: String, password: String) async throws -> ApiResponse
    func register(name: String, username: String, email: String, password: String) async throws -> ApiResponse
    func fetchUser(userId: String) async throws -> User
}

final class AuthManager: AuthService {
    
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func login(email: String, password: String) async throws -> ApiResponse {
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        let endpoint = UserEndpoint.login(body: body)
        return try await networkManager.fetch(with: endpoint)
    }
    
    func register(name: String, username: String, email: String, password: String) async throws -> ApiResponse {
        let body: [String: Any] = [
            "name": name,
            "username": username,
            "email": email,
            "password": password
        ]
        let endpoint = UserEndpoint.register(body: body)
        return try await networkManager.fetch(with: endpoint)
    }
    
    func fetchUser(userId: String) async throws -> User {
        let endpoint = UserEndpoint.fetchUser(userId: userId)
        return try await networkManager.fetch(with: endpoint)
    }
    
}
