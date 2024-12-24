//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/19/24.
//

import Foundation

protocol AuthManagerProtocol {
    func login(email: String, password: String) async throws -> ApiResponse
    func register(username: String, email: String, password: String) async throws -> ApiResponse
    func fetchUser(userId: String) async throws -> ApiResponse
}

final class AuthManager: AuthManagerProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func login(email: String, password: String) async throws -> ApiResponse {    
        let requestBody = ["email": email, "password": password]
        return try await networkManager.request(
            endpoint: "/users/login",
            method: .post,
            body: requestBody,
            headers: nil
        )
    }

    func register(username: String, email: String, password: String) async throws -> ApiResponse {
        let requestBody = ["username": username, "email": email, "password": password]
        return try await networkManager.request(
            endpoint: "/users",
            method: .post,
            body: requestBody,
            headers: nil
        )
    }
    
    func fetchUser(userId: String) async throws -> ApiResponse {
        return try await networkManager.request(
            endpoint: "/users/\(userId)",
            method: .get,
            body: nil,
            headers: nil
        )
    }
}

