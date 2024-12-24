//
//  UserEndpoint.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import Foundation

//enum UserEndpoint: Endpoint {
//    
//    case getUsers
//    case getUser(userId: String)
//    case registerUser(username: String, email: String, password: String)
//    case loginUser(email: String, password: String)
//    
//    var path: String {
//        switch self {
//        case .getUsers:
//            return "/users"
//        case .getUser(let userId):
//            return "/users/\(userId)"
//        case .registerUser:
//            return "/users"
//        case .loginUser:
//            return "/users/login"
//        }
//    }
//    
//    var body: [String: Any]? {
//        switch self {
//        case .registerUser(let username, let email, let password):
//            return [
//                "username": username,
//                "email": email,
//                "password": password
//            ]
//        case .loginUser(let email, let password):
//            return [
//                "email": email,
//                "password": password
//            ]
//        default:
//            return nil
//        }
//    }
//    
//    var method: HTTPMethod {
//        switch self {
//        case .getUsers, .getUser:
//            return .get
//        case .registerUser, .loginUser:
//            return .post
//        }
//    }
//}

/*enum UserEndpoint: Endpoint {
    case login(email: String, password: String)
    case register(username: String, email: String, password: String)
    case fetchUser(userId: String)

    var baseURL: URL {
        return URL(string: "http://localhost:3000/")!
    }

    var path: String {
        switch self {
        case .login:
            return "/users/login"
        case .register:
            return "/users"
        case .fetchUser(let userId):
            return "/users/\(userId)"
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

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var body: Data? {
        switch self {
        case .login(let email, let password):
            let params = ["email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: params)
        case .register(let username, let email, let password):
            let params = ["username": username, "email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: params)
        case .fetchUser:
            return nil
        }
    }
} */
