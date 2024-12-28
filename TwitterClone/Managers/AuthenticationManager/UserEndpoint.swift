//
//  UserEndpoint.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import Foundation

enum UserEndpoint: Endpoint {
    case login(body: [String: Any])
    case register(body: [String: Any])
    case fetchUser(userId: String)

    var baseURL: URL {
        return URL(string: "\(K.baseURL)users")!
    }

    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        case .fetchUser(let userId):
            return userId
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        case .fetchUser:
            return .get
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var body: [String: Any]? {
        switch self {
        case .login(let body), .register(let body):
            return body
        case .fetchUser:
            return nil
        }
    }
}
