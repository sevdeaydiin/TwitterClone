//
//  FeedViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 6.08.2024.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        RequestServices.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let tweets = try JSONDecoder().decode([Tweet].self, from: data!)
                    DispatchQueue.main.async {
                        self?.tweets = tweets
                    }
                } catch {
                    print("JSON decode error: \(error)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

