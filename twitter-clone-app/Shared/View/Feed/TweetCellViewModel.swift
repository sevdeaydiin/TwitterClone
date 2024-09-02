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
    let currentUser: User
    
    init(tweet: Tweet, currentUser: User) {
        self.tweet = tweet
        self.currentUser = currentUser
        self.fetchUser(userId: tweet.user)
        checkIfUSerLikedPost()
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
    
    
    func like() {
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)tweets/\(self.tweet.id)/like"
        RequestServices.likeTwee(id: self.tweet.id) { result in
            print("tweet has been liked")
        }
        self.tweet.didLike = true
    }
    
    func unlike() {
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)tweets/\(self.tweet.id)/unlike"
        RequestServices.likeTwee(id: self.tweet.id) { result in
            print("tweet has been unliked")
        }
        self.tweet.didLike = false
    }
    
    func checkIfUSerLikedPost() {
        if(self.tweet.likes.contains(self.currentUser.id)) {
            self.tweet.didLike = true
        } else {
            self.tweet.didLike = false
        }
    }
    
}
