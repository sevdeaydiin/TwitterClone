//
//  Tweet.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 1.08.2024.
//

import SwiftUI

struct Tweet: Identifiable, Decodable {

    let _id: String
    var id: String {
        return _id
    }
    let text: String
    let userId: String
    let username: String
    let user: String
    let image: String?
}
