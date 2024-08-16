//
//  User.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 22.07.2024.
//

import Foundation

struct ApiResponse: Decodable {
    var user: User
    var token: String
}

struct User: Decodable, Identifiable {
    var _id: String
    var id: String {
        return _id
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
}
