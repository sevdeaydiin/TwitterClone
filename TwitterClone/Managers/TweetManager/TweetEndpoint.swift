//
//  TweetEndpoint.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import Foundation

enum TweetEndpoint: Endpoint {
    case postTweet(body: [String: Any])
    case fetchTweets
    
    var baseURL: URL {
        return URL(string: "\(K.baseURL)tweets")!
    }
    
    var path: String {
        switch self {
        case .postTweet:
            return ""
        case .fetchTweets:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postTweet:
            return .post
        case .fetchTweets:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var body: [String : Any]? {
        switch self {
        case .postTweet(let body):
            return body
        case .fetchTweets:
            return nil
        }
    }
}
