//
//  TweetEndpoint.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import Foundation

enum TweetEndpoint: Endpoint {
    
    case getTweets
    
    var path: String {
        switch self {
        case .getTweets:
            return "/tweets"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    
}
