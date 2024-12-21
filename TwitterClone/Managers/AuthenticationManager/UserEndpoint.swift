//
//  UserEndpoint.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import Foundation

enum UserEndpoint: Endpoint {
    
    case getUsers
    case getUser(userId: String)
    case registerUser(username: String, email: String, password: String)
    case loginUser(email: String, password: String)
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUser(let userId):
            return "/users/\(userId)"
        case .registerUser:
            return "/users"
        case .loginUser:
            return "/users/login"
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .registerUser(let username, let email, let password):
            return [
                "username": username,
                "email": email,
                "password": password
            ]
        case .loginUser(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUsers, .getUser:
            return .get
        case .registerUser, .loginUser:
            return .post
        }
    }
}
