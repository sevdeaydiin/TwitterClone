//
//  ProfileViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 10.08.2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    @Published var tweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        fetchTweets()
    }
    
    func fetchTweets() {
        RequestServices.requestDomain = "\(NetworkConstants.baseURL)tweets/\(self.user.id)"

        RequestServices.fetchTweets { result in
            switch result {
            case .success(let data):
                guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data!) else { return }
                DispatchQueue.main.async {
                    self.tweets = tweets
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
