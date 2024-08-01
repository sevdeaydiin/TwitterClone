//
//  CreateTweetViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 1.08.2024.
//

import SwiftUI

class CreateTweetViewModel: ObservableObject {
    
    func uploadPost(text: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        
        RequestServices.postTweet(text: text, user: user.name, username: user.username, userId: user.id) { result in
            print(result ?? "result")
        }
        
    }
}
