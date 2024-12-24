//
//  TweetManager.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import Foundation

//protocol TweetManagerProtocol {
//    func fetchTweets() async throws -> [Tweet]
//    func postTweet(text: String, image: Data?) async throws -> Tweet
//    func likeTweet(tweetId: String) async throws
//    func unlikeTweet(tweetId: String) async throws
//}
//
//final class TweetManager: TweetManagerProtocol {
//    private let networkManager: NetworkManagerProtocol
//    private let token: String
//
//    init(networkManager: NetworkManagerProtocol, token: String) {
//        self.networkManager = networkManager
//        self.token = token
//    }
//
//    func fetchTweets() async throws -> [Tweet] {
//        try await networkManager.request(
//            endpoint: "tweets",
//            method: .get,
//            body: nil,
//            headers: ["Authorization": "Bearer \(token)"]
//        )
//    }
//
//    func postTweet(text: String, image: Data?) async throws -> Tweet {
//        let requestBody: [String: Any] = [
//            "text": text,
//            "image": image != nil ? image!.base64EncodedString() : NSNull()
//        ]
//        return try await networkManager.request(
//            endpoint: "tweets",
//            method: .post,
//            body: requestBody,
//            headers: ["Authorization": "Bearer \(token)"]
//        )
//    }
//
//    func likeTweet(tweetId: String) async throws {
//        _ = try await networkManager.request(
//            endpoint: "tweets/\(tweetId)/like",
//            method: .post,
//            body: nil,
//            headers: ["Authorization": "Bearer \(token)"]
//        )
//    }
//
//    func unlikeTweet(tweetId: String) async throws {
//        _ = try await networkManager.request(
//            endpoint: "tweets/\(tweetId)/unlike",
//            method: .post,
//            body: nil,
//            headers: ["Authorization": "Bearer \(token)"]
//        )
//    }
//}
