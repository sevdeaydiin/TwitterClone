//
//  UserEndpoint.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/17/24.
//

import Foundation

enum UserEndpoint: Endpoint {

    case getUsers
    case getUser(userId: Int)
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUser(let userId):
            return "/users/\(userId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
}
