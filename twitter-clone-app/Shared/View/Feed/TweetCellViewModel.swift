//
//  TweetCellViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 6.08.2024.
//

import SwiftUI

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
        print("viewmodel: \(tweet)")
    }
}
