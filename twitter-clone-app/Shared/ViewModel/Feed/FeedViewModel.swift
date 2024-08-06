//
//  FeedViewModel.swift
//  twitter-clone-app
//
//  Created by Sevde Aydın on 6.08.2024.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    
    init(){
        fetchTweets()
    }
    
    func fetchTweets() {
        
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        //"\(NetworkConstants.baseURL)tweets"
        RequestServices.fetchTweets { res in
            switch res {
            case .success(let data):
                do {
                    let jsonString = String(data: data!, encoding: .utf8)
                    print("Response JSON: \(jsonString ?? "")")
                    let tweets = try JSONDecoder().decode([Tweet].self, from: data!)
                    DispatchQueue.main.async {
                        self.tweets = tweets
                        print(tweets)
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
