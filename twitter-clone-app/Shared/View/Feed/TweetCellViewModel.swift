//
//  TweetCellViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 6.08.2024.
//

import SwiftUI

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    @Published var user: User?
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.fetchUser(userId: tweet.user)
        //print("viewmodel: \(tweet)")
    }
    
    func fetchUser(userId: String) {
        AuthServices.requestDomain = "\(NetworkConstants.baseURL)users/\(userId)"
        
        AuthServices.fetchUser(id: userId) { result in
            switch result {
                case .success(let data):
                guard let user = try? JSONDecoder().decode(User.self, from: data ) else { return }
                    DispatchQueue.main.async {
                        self.user = user
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        }
    }
}
