//
//  User.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import Foundation

struct ApiResponse: Decodable {
    var user: User
    var token: String
}

struct User: Decodable, Identifiable {
    struct ObjectID: Decodable {
        let oid: String

        private enum CodingKeys: String, CodingKey {
            case oid = "$oid"
        }
    }
    
    var _id: ObjectID
    var id: String {
        return _id.oid
    }
    
    let username: String
    var name: String
    let email: String
    var location: String?
    var bio: String?
    var website: String?
    var avatarExists: Bool?
    var followers: [String]?
    var following: [String]?
    var isCurrentUser: Bool? = false
    var isFollow: Bool? = false
}
