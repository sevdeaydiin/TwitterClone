//
//  User.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/15/24.
//

import Foundation

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
    var isFollow: Bool? = false
}
