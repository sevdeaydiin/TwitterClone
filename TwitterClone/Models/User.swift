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
    var _id: String
    var id: String { return _id }
    let username: String
    var name: String
    let email: String
    var location: String?
    var bio: String?
    var website: String?
    var avatarExists: Bool?
    var followers: [String]?
    var followings: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case _id, username, name, email, location, bio, website, avatarExists, followers, followings
    }
}

extension User {
    static var mockData: Self {
        .init(_id: "123", username: "sevde", name: "sevde", email: "sevde.aydin@gmail.com")
    }
}
