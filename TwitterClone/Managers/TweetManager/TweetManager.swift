//
//  TweetManager.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import Foundation

protocol TweetService {
    func fetchTweets() async throws -> [Tweet]
    func postTweet(text: String, username: String, userId: String) async throws -> Tweet
    //func likeTweet(tweetId: String) async throws
    //func unlikeTweet(tweetId: String) async throws
}

final class TweetManager: TweetService {
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func fetchTweets() async throws -> [Tweet] {
        let endpoint = TweetEndpoint.fetchTweets
        return try await networkManager.fetch(with: endpoint)
    }
    
    func postTweet(text: String, username: String, userId: String) async throws -> Tweet {
        let body: [String: Any] = [
            "text": text,
            "username": username,
            "userId": userId
        ]
        let endpoint = TweetEndpoint.postTweet(body: body)
        return try await networkManager.fetch(with: endpoint)
    }
}

